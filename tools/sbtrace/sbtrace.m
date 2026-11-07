// 注入模拟器内的 App：记录状态栏更新链路和视图树，只读，不修改任何状态栏数据。
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

static FILE *logFile;
static NSMutableSet *seenStacks;
static char armedPath[1024];

static void logLine(NSString *s) {
    if (!logFile) return;
    @synchronized (seenStacks) {
        fprintf(logFile, "%.3f %s\n", [NSDate date].timeIntervalSince1970, s.UTF8String);
        fflush(logFile);
    }
}

typedef id (*Fn)(id, SEL, void *, void *, void *, void *);

static NSString *describeArg(id data) {
    if (!data || ![data respondsToSelector:NSSelectorFromString(@"timeEntry")]) return @"";
    @try {
        id entry = [data valueForKey:@"timeEntry"];
        id text = [entry respondsToSelector:NSSelectorFromString(@"stringValue")] ? [entry valueForKey:@"stringValue"] : nil;
        return [NSString stringWithFormat:@" time=%@", text];
    } @catch (__unused id e) { return @""; }
}

#define HOOKS 8
static IMP originals[HOOKS];
static const char *names[HOOKS];
static BOOL argIsObject[HOOKS];

static id trace(int i, id self, SEL _cmd, void *a, void *b, void *c, void *d) {
    NSString *detail = argIsObject[i] ? describeArg((__bridge id)a) : @"";
    logLine([NSString stringWithFormat:@"CALL %s%@", names[i], detail]);
    NSString *key = @(names[i]);
    BOOL first = NO;
    if (access(armedPath, F_OK) == 0) {
        @synchronized (seenStacks) { if (![seenStacks containsObject:key]) { [seenStacks addObject:key]; first = YES; } }
    }
    if (first) for (NSString *f in [NSThread callStackSymbols])
        logLine([NSString stringWithFormat:@"  STACK<%s> %@", names[i], f]);
    return ((Fn)originals[i])(self, _cmd, a, b, c, d);
}

#define TRAMP(N) static id t##N(id s, SEL c, void *a, void *b, void *d, void *e) { return trace(N, s, c, a, b, d, e); }
TRAMP(0) TRAMP(1) TRAMP(2) TRAMP(3) TRAMP(4) TRAMP(5) TRAMP(6) TRAMP(7)
static IMP tramps[HOOKS] = {(IMP)t0,(IMP)t1,(IMP)t2,(IMP)t3,(IMP)t4,(IMP)t5,(IMP)t6,(IMP)t7};

static void hook(int i, const char *cls, BOOL isClassMethod, const char *sel, BOOL objArg) {
    Class c = objc_getClass(cls);
    if (c && isClassMethod) c = object_getClass(c);
    Method m = c ? class_getInstanceMethod(c, sel_registerName(sel)) : NULL;
    names[i] = strdup([NSString stringWithFormat:@"%c[%s %s]", isClassMethod ? '+' : '-', cls, sel].UTF8String);
    argIsObject[i] = objArg;
    if (!m) { logLine([NSString stringWithFormat:@"HOOK 缺失 %s", names[i]]); return; }
    originals[i] = method_setImplementation(m, tramps[i]);
    logLine([NSString stringWithFormat:@"HOOK %s", names[i]]);
}

static void walk(UIView *v, int depth, BOOL inside) {
    NSString *name = NSStringFromClass(v.class);
    BOOL match = [name rangeOfString:@"StatusBar"].location != NSNotFound;
    BOOL now = inside || match;
    if (now) {
        NSString *text = [v respondsToSelector:@selector(text)] ? [NSString stringWithFormat:@" text=%@", [(id)v text]] : @"";
        logLine([NSString stringWithFormat:@"VIEW %*s%@ %@%@", depth * 2, "", name, NSStringFromCGRect(v.frame), text]);
    }
    for (UIView *s in v.subviews) walk(s, now ? depth + 1 : depth, now);
}

static void dumpClass(const char *name) {
    Class c = objc_getClass(name);
    if (!c) { logLine([NSString stringWithFormat:@"CLASS 缺失 %s", name]); return; }
    logLine([NSString stringWithFormat:@"CLASS %s : %s [%s]", name, class_getName(class_getSuperclass(c)), class_getImageName(c)]);
    for (int meta = 0; meta < 2; meta++) {
        unsigned n = 0;
        Method *ms = class_copyMethodList(meta ? object_getClass(c) : c, &n);
        for (unsigned i = 0; i < n; i++)
            logLine([NSString stringWithFormat:@"  M %c %s", meta ? '+' : '-', sel_getName(method_getName(ms[i]))]);
        free(ms);
    }
}

static void dumpClassNames(void) {
    unsigned n = 0;
    Class *cs = objc_copyClassList(&n);
    for (unsigned i = 0; i < n; i++) {
        const char *name = class_getName(cs[i]);
        if (strstr(name, "STUIStatusBar") || strstr(name, "SBStatusBar") || strstr(name, "STStatusBarData"))
            logLine([NSString stringWithFormat:@"NAME %s [%s]", name, [@(class_getImageName(cs[i]) ?: "?") lastPathComponent].UTF8String]);
    }
    free(cs);
}

static void walkLayers(CALayer *l, int depth) {
    if (depth > 9) return;
    NSString *text = [l isKindOfClass:CATextLayer.class] ? [NSString stringWithFormat:@" text=%@", ((CATextLayer *)l).string] : @"";
    id delegate = l.delegate;
    NSString *owner = [delegate isKindOfClass:UIView.class] ? NSStringFromClass([delegate class]) : @"-";
    NSString *lbl = [delegate respondsToSelector:@selector(text)] ? [NSString stringWithFormat:@" text=%@", [delegate text]] : text;
    logLine([NSString stringWithFormat:@"LAYER %*s%@ view=%@ %@%@", depth * 2, "", NSStringFromClass(l.class), owner, NSStringFromCGRect(l.frame), lbl]);
    for (CALayer *s in l.sublayers) walkLayers(s, depth + 1);
}

static UIView *findView(UIView *v, const char *cls) {
    if (!strcmp(class_getName(v.class), cls)) return v;
    for (UIView *s in v.subviews) { UIView *r = findView(s, cls); if (r) return r; }
    return nil;
}

static void dumpTree(NSString *tag) {
    logLine([@"TREE " stringByAppendingString:tag]);
    // SpringBoard 的窗口不全在 connectedScenes 里，改用私有接口取全部窗口
    typedef NSArray *(*AllWindows)(id, SEL, BOOL, BOOL);
    SEL sel = NSSelectorFromString(@"allWindowsIncludingInternalWindows:onlyVisibleWindows:");
    NSArray *all = ((AllWindows)objc_msgSend)(UIWindow.class, sel, YES, NO);
    logLine([NSString stringWithFormat:@"WINDOWS %lu", (unsigned long)all.count]);
    for (UIWindow *w in all) {
        if ([NSStringFromClass(w.class) rangeOfString:@"StatusBar"].location != NSNotFound || w.windowLevel > 1000)
            logLine([NSString stringWithFormat:@"WINDOW %@ level=%.0f hidden=%d", NSStringFromClass(w.class), w.windowLevel, w.hidden]);
        walk(w, 1, NO);
        if ([NSStringFromClass(w.class) isEqual:@"SBStatusBarWindow"] && !w.hidden) {
            UIView *bar = findView(w, "STUIStatusBar");
            if (bar) walkLayers(bar.layer, 0);
        }
    }
}

__attribute__((constructor)) static void start(void) {
    const char *path = getenv("SBTRACE_LOG");
    if (!path) return;
    logFile = fopen(path, "a");
    seenStacks = [NSMutableSet set];
    snprintf(armedPath, sizeof armedPath, "%s.armed", path);
    logLine(@"LOADED");
    dispatch_async(dispatch_get_main_queue(), ^{
        hook(0, "STUIStatusBar_Wrapper", NO, "statusBarStateProvider:didPostStatusBarData:withActions:", NO);
        hook(1, "STUIStatusBar_Wrapper", NO, "_effectiveDataFromData:activeOverride:activeBackgroundActivity:canUpdateBackgroundActivity:", NO);
        hook(2, "STUIStatusBar_Wrapper", NO, "_updateWithData:force:", NO);
        hook(3, "STUIStatusBar", NO, "updateWithData:", YES);
        hook(4, "STUIStatusBarDataAggregator", NO, "updateWithData:", YES);
        hook(5, "STUIStatusBar", NO, "_updateWithAggregatedData:", YES);
        hook(6, "STUIStatusBar", NO, "_updateDisplayedItemsWithData:styleAttributes:extraAnimations:", YES);
        hook(7, "SBStatusBarStateAggregator", NO, "_updateTimeItems", NO);
        dumpClass("STUIStatusBarTimeItem");
        for (int i = 1; i <= 3; i++)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dumpTree([NSString stringWithFormat:@"t=%ds", i * 10]);
            });
    });
}
