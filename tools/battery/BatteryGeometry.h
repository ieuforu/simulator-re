// 根据 iOS 17.4 UIKitCore 的反汇编还原；不是 Apple 原始源码。
// 对应 +[_UIBatteryView _pinBezierPathForSize:isComplex:]。
// 输入为系统参数表里的有效尺寸。这里不依赖任何私有类。
#import <UIKit/UIKit.h>

static UIBezierPath *BatteryPinPath(CGSize size, BOOL complex) {
    CGFloat w = size.width, h = size.height;
    UIBezierPath *p = [UIBezierPath bezierPath];
    if (complex) {
        // 另一分支：右上、右下各一段半径 w 的四分之一圆，右侧有直边。
        [p moveToPoint:CGPointZero];
        [p addArcWithCenter:CGPointMake(0, w) radius:w
                startAngle:3 * M_PI_2 endAngle:0 clockwise:YES];
        [p addLineToPoint:CGPointMake(w, h - w)];
        [p addArcWithCenter:CGPointMake(0, h - w) radius:w
                startAngle:0 endAngle:M_PI_2 clockwise:YES];
    } else {
        // 状态栏分支：圆心位于切线 x=0 左侧，保留圆的右侧小段。
        CGFloat r = h / 2;
        CGFloat d = r - w;
        CGFloat halfChord = sqrt(r * r - d * d);
        CGFloat angle = acos(d / r);
        [p moveToPoint:CGPointMake(0, r - halfChord)];
        // UIKit 先自动连线到圆弧起点（下交点），然后沿右侧画回上交点。
        [p addArcWithCenter:CGPointMake(-d, r) radius:r
                startAngle:angle endAngle:-angle clockwise:NO];
    }
    [p closePath];
    return p;
}
