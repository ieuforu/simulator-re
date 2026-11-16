// 导出真实 CGPath，并逐元素验证 cap 的还原代码。
// pathprobe <输出目录> [--wait]；--wait 保持进程存活，供 lldb 附加反汇编。
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <unistd.h>
#import "BatteryGeometry.h"

static void collect(void *info, const CGPathElement *e) {
    NSMutableArray *a = (__bridge NSMutableArray *)info;
    int count[] = {1, 1, 2, 3, 0};
    NSArray *names = @[@"M", @"L", @"Q", @"C", @"Z"];
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < count[e->type]; i++)
        [points addObject:@[@(e->points[i].x), @(e->points[i].y)]];
    [a addObject:@{@"op":names[e->type], @"points":points}];
}
static NSDictionary *describePath(UIBezierPath *p) {
    NSMutableArray *a = [NSMutableArray array];
    CGPathApply(p.CGPath, (__bridge void *)a, collect);
    return @{@"bounds":NSStringFromCGRect(CGPathGetPathBoundingBox(p.CGPath)), @"elements":a};
}
static double difference(NSArray *a, NSArray *b) {
    if (a.count != b.count) return INFINITY;
    double delta = 0;
    for (NSUInteger i = 0; i < a.count; i++) {
        if (![a[i][@"op"] isEqual:b[i][@"op"]]) return INFINITY;
        NSArray *pa = a[i][@"points"], *pb = b[i][@"points"];
        if (pa.count != pb.count) return INFINITY;
        for (NSUInteger j = 0; j < pa.count; j++) for (int k = 0; k < 2; k++)
            delta = MAX(delta, fabs([pa[j][k] doubleValue] - [pb[j][k] doubleValue]));
    }
    return delta;
}
int main(int argc, char **argv) { @autoreleasepool {
    if (argc < 2 || argc > 3 || (argc == 3 && strcmp(argv[2], "--wait"))) {
        fprintf(stderr, "usage: pathprobe <output-directory> [--wait]\n"); return 2;
    }
    dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI", RTLD_NOW);
    Class c = NSClassFromString(@"_UIBatteryView");
    SEL pinSelector = sel_getUid("_pinBezierPathForSize:isComplex:");
    if (![c respondsToSelector:pinSelector]) { fprintf(stderr, "pin method unavailable\n"); return 1; }
    NSString *dir = @(argv[1]); NSError *error = nil;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error]) {
        fprintf(stderr, "%s\n", error.description.UTF8String); return 1;
    }
    NSMutableDictionary *out = [NSMutableDictionary dictionary];
    out[@"systemVersion"] = UIDevice.currentDevice.systemVersion;
    double worst = 0;
    for (NSArray *s in @[@[@(4/3.0),@4.5], @[@(5/3.0),@5], @[@2,@5], @[@1,@5]]) {
        for (int complex = 0; complex < 2; complex++) {
            CGSize size = CGSizeMake([s[0] doubleValue], [s[1] doubleValue]);
            UIBezierPath *actual = ((id (*)(id,SEL,CGSize,BOOL))objc_msgSend)(c, pinSelector, size, complex);
            NSDictionary *got = describePath(actual), *expected = describePath(BatteryPinPath(size, complex));
            double delta = difference(got[@"elements"], expected[@"elements"]);
            worst = MAX(worst, delta);
            NSString *key = [NSString stringWithFormat:@"pin-%.8fx%.8f-complex%d", size.width, size.height, complex];
            out[key] = got;
            printf("%s: max coordinate delta %.17g pt\n", key.UTF8String, delta);
        }
    }
    // 导出与第 8 档外壳构造相同的公开 UIKit 路径，保留控制点用于研究圆角。
    CGFloat lw = 7/6.0;
    CGRect body = CGRectInset(CGRectMake(0, 0, 85/3.0, 43/3.0), lw/2, lw/2);
    out[@"rounded-body"] = describePath([UIBezierPath bezierPathWithRoundedRect:body cornerRadius:body.size.height/3.125]);
    SEL fillSelector = sel_getUid("_continuousRoundedCARectBezierPath:withRoundedCorners:cornerRadius:segments:");
    if ([UIBezierPath respondsToSelector:fillSelector]) {
        CGRect fill = CGRectMake(0, 0, 71/3.0, 29/3.0);
        CGFloat r = fill.size.height / 3.125;
        UIBezierPath *actual = ((id (*)(id,SEL,CGRect,NSUInteger,CGSize,NSUInteger))objc_msgSend)(
            UIBezierPath.class, fillSelector, fill, (NSUInteger)-1, CGSizeMake(r, r), 16);
        out[@"rounded-fill-ca"] = describePath(actual);
        out[@"rounded-fill-public"] = describePath([UIBezierPath bezierPathWithRoundedRect:fill cornerRadius:r]);
    }
    out[@"fillFrameMethodType"] = @(method_getTypeEncoding(class_getInstanceMethod(c, sel_getUid("_fillLayerFrame:cornerRadius:"))));
    for (NSString *name in @[@"_boltBezierPath", @"_boltMaskBezierPath"]) {
        SEL sel = NSSelectorFromString(name);
        if ([c respondsToSelector:sel]) out[name] = describePath(((id (*)(id,SEL))objc_msgSend)(c, sel));
    }
    // 必须使用同一运行时的 ivar 偏移，不能拿 iOS 27 的表注释 iOS 17。
    NSMutableString *ivars = [NSMutableString string], *methods = [NSMutableString string];
    for (NSString *name in @[@"_UIBatteryView", @"_UIStaticBatteryView"]) {
        Class cls = NSClassFromString(name); unsigned count = 0;
        Ivar *list = class_copyIvarList(cls, &count);
        for (unsigned i = 0; i < count; i++) [ivars appendFormat:@"%td %s\n", ivar_getOffset(list[i]), ivar_getName(list[i])];
        free(list);
        for (int meta = 0; meta < 2; meta++) {
            Method *ms = class_copyMethodList(meta ? object_getClass(cls) : cls, &count);
            for (unsigned i = 0; i < count; i++) [methods appendFormat:@"%c[%@ %s]\n", meta ? '+' : '-', name, sel_getName(method_getName(ms[i]))];
            free(ms);
        }
    }
    NSData *json = [NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:&error];
    if (!json || ![json writeToFile:[dir stringByAppendingPathComponent:@"paths.json"] options:NSDataWritingAtomic error:&error] ||
        ![ivars writeToFile:[dir stringByAppendingPathComponent:@"ivars.txt"] atomically:YES encoding:NSUTF8StringEncoding error:&error] ||
        ![methods writeToFile:[dir stringByAppendingPathComponent:@"methods-all.txt"] atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        fprintf(stderr, "%s\n", error.description.UTF8String); return 1;
    }
    printf("iOS %s, pid=%d, 8 pin paths: %s (tolerance 1e-12 pt)\n", UIDevice.currentDevice.systemVersion.UTF8String, getpid(), worst <= 1e-12 ? "PASS" : "FAIL");
    fflush(stdout);
    if (worst > 1e-12) return 1;
    if (argc == 3) while (1) pause();
    return 0;
} }
