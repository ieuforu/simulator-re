// 注入 SpringBoard（只读）：收到触发文件后导出真实状态栏电池视图的属性、位置、图层树和贴图。
// 环境变量 SBBATTERY_DIR=<目录>；在该目录写入 trigger 文件（内容为标签）即导出一次，完成后删除 trigger。
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

static NSString *dir;
static NSMutableString *out;
static int imgCounter;
static NSString *curTag;

static void pathApplier(void *info, const CGPathElement *e) {
    NSMutableString *s = (__bridge NSMutableString *)info;
    const char *names[] = {"M", "L", "Q", "C", "Z"};
    int cnt[] = {1, 1, 2, 3, 0};
    [s appendFormat:@" %s", names[e->type]];
    for (int i = 0; i < cnt[e->type]; i++) [s appendFormat:@" %.4f,%.4f", e->points[i].x, e->points[i].y];
}
static NSString *colorDesc(CGColorRef c) {
    if (!c) return @"nil";
    UIColor *u = [UIColor colorWithCGColor:c];
    CGFloat r, g, b, a;
    if ([u getRed:&r green:&g blue:&b alpha:&a]) return [NSString stringWithFormat:@"rgba(%.3f,%.3f,%.3f,%.3f)", r, g, b, a];
    return u.description;
}
static NSString *R(CGRect r) { return [NSString stringWithFormat:@"(%.4f,%.4f %.4fx%.4f)", r.origin.x, r.origin.y, r.size.width, r.size.height]; }

static void dumpLayer(CALayer *l, int depth) {
    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"%*s%@ frame=%@", depth * 2, "", l.class, R(l.frame)];
    if (!CGAffineTransformIsIdentity(l.affineTransform)) [s appendFormat:@" transform=%@", NSStringFromCGAffineTransform(l.affineTransform)];
    if (l.cornerRadius) [s appendFormat:@" corner=%.4f(%@)", l.cornerRadius, l.cornerCurve];
    if (l.backgroundColor) [s appendFormat:@" bg=%@", colorDesc(l.backgroundColor)];
    if (l.opacity != 1) [s appendFormat:@" opacity=%.3f", l.opacity];
    if (l.hidden) [s appendString:@" HIDDEN"];
    if (l.masksToBounds) [s appendString:@" masksToBounds"];
    if (l.compositingFilter) [s appendFormat:@" filter=%@", l.compositingFilter];
    if (l.filters.count) [s appendFormat:@" filters=%@", [l.filters valueForKey:@"name"]];
    @try { id mc = [l valueForKey:@"contentsMultiplyColor"]; if (mc) [s appendFormat:@" multiply=%@", colorDesc((__bridge CGColorRef)mc)]; } @catch (id e) {}
    if (l.contents && CFGetTypeID((__bridge CFTypeRef)l.contents) == CGImageGetTypeID()) {
        CGImageRef img = (__bridge CGImageRef)l.contents;
        NSString *name = [NSString stringWithFormat:@"%@-img%02d.png", curTag, ++imgCounter];
        [UIImagePNGRepresentation([UIImage imageWithCGImage:img]) writeToFile:[dir stringByAppendingPathComponent:name] atomically:YES];
        [s appendFormat:@" contents=%zux%zu scale=%.2f -> %@", CGImageGetWidth(img), CGImageGetHeight(img), l.contentsScale, name];
    } else if (l.contents) [s appendFormat:@" contents=%@", l.contents];
    id d = l.delegate;
    if ([d isKindOfClass:UILabel.class]) {
        UILabel *lb = d;
        [s appendFormat:@" LABEL text=\"%@\" font=%@ %.3fpt color=%@", lb.text, lb.font.fontName, lb.font.pointSize, colorDesc(lb.textColor.CGColor)];
    } else if (d) [s appendFormat:@" <%@>", [d class]];
    if ([l isKindOfClass:CAShapeLayer.class]) {
        CAShapeLayer *sh = (CAShapeLayer *)l;
        [s appendFormat:@" shape line=%.3f fill=%@ stroke=%@ path:", sh.lineWidth, colorDesc(sh.fillColor), colorDesc(sh.strokeColor)];
        if (sh.path) CGPathApply(sh.path, (__bridge void *)s, pathApplier);
    }
    [out appendFormat:@"%@\n", s];
    if (l.mask) { [out appendFormat:@"%*s[mask]\n", depth * 2 + 2, ""]; dumpLayer(l.mask, depth + 2); }
    for (CALayer *c in l.sublayers) dumpLayer(c, depth + 1);
}

static void visit(UIView *v, NSMutableArray *found) {
    if ([v isKindOfClass:NSClassFromString(@"_UIBatteryView")]) [found addObject:v];
    for (UIView *s in v.subviews) visit(s, found);
}

static NSString *val(id o, NSString *k) { @try { return [[o valueForKey:k] description]; } @catch (id e) { return @"?"; } }

static void dumpAll(NSString *tag) {
    out = [NSMutableString string];
    curTag = tag;
    imgCounter = 0;
    NSArray *windows = ((id (*)(id, SEL, BOOL, BOOL))objc_msgSend)(UIWindow.class, sel_getUid("allWindowsIncludingInternalWindows:onlyVisibleWindows:"), YES, NO);
    NSMutableArray *found = [NSMutableArray array];
    for (UIWindow *w in windows) visit(w, found);
    [out appendFormat:@"tag=%@ windows=%lu batteryViews=%lu\n", tag, (unsigned long)windows.count, (unsigned long)found.count];
    for (UIView *v in found) {
        CGRect inScreen = [v convertRect:v.bounds toCoordinateSpace:v.window.screen.coordinateSpace];
        [out appendFormat:@"\n=== %@ %p window=%@ hidden=%d alpha=%.2f inScreen=%@ screenScale=%.1f\n", v.class, v, v.window.class,
         v.isHidden, v.alpha, R(inScreen), v.window.screen.scale];
        for (NSString *k in @[@"iconSize", @"rounded", @"internalSizeCategory", @"sizeCategory", @"showsPercentage", @"showsInlineChargingIndicator",
                              @"chargePercent", @"chargingState", @"saverModeActive", @"lowBatteryMode", @"lowBatteryChargePercentThreshold",
                              @"fillColor", @"bodyColor", @"pinColor", @"boltColor", @"inactiveColor", @"bodyColorAlpha", @"pinColorAlpha"])
            [out appendFormat:@"  %@ = %@\n", k, val(v, k)];
        NSMutableArray *chain = [NSMutableArray array];
        for (UIView *s = v.superview; s && chain.count < 6; s = s.superview) [chain addObject:[NSString stringWithFormat:@"%@ %@", s.class, R(s.frame)]];
        [out appendFormat:@"  superviews: %@\n", [chain componentsJoinedByString:@" <- "]];
        [out appendFormat:@"  traits: scale=%.1f style=%ld contrast=%ld\n", v.traitCollection.displayScale, (long)v.traitCollection.userInterfaceStyle,
         (long)v.traitCollection.accessibilityContrast];
        dumpLayer(v.layer, 1);
    }
    [out writeToFile:[dir stringByAppendingFormat:@"/%@.txt", tag] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

__attribute__((constructor)) static void start(void) {
    const char *d = getenv("SBBATTERY_DIR");
    if (!d) return;
    dir = @(d);
    NSString *trigger = [dir stringByAppendingPathComponent:@"trigger"];
    dispatch_source_t t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(t, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), NSEC_PER_SEC / 2, NSEC_PER_SEC / 10);
    dispatch_source_set_event_handler(t, ^{
        NSString *tag = [NSString stringWithContentsOfFile:trigger encoding:NSUTF8StringEncoding error:nil];
        if (!tag) return;
        [[NSFileManager defaultManager] removeItemAtPath:trigger error:nil];
        tag = [tag stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        dispatch_async(dispatch_get_main_queue(), ^{ dumpAll(tag.length ? tag : @"dump"); });
    });
    dispatch_resume(t);
    static dispatch_source_t keep; keep = t;
}
