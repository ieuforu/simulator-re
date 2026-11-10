// STUIStatusBarStaticBatteryView 按 iconSize 1..19（rounded=YES，和真实状态栏一致）导出参数和布局
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <dlfcn.h>
#define D(o,s) (((double (*)(id, SEL, id))objc_msgSend)(o, sel_getUid(s), o.traitCollection))
int main(int argc, char **argv) { @autoreleasepool {
  dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI", RTLD_NOW);
  Class C = NSClassFromString(@"STUIStatusBarStaticBatteryView");
  long from = argc > 1 ? atol(argv[1]) : 1, to = argc > 2 ? atol(argv[2]) : 19;
  printf("iOS %s\n", UIDevice.currentDevice.systemVersion.UTF8String);
  for (long n = from; n <= to; n++) for (int mode = 0; mode < 3; mode++) {
    // mode 0：放电 50；1：百分比放电 50；2：百分比充电 50
    __block UIView *v;
    @try { [UIView performWithoutAnimation:^{
      v = [[C alloc] initWithFrame:CGRectZero];
      ((void (*)(id, SEL, long))objc_msgSend)(v, sel_getUid("setInternalSizeCategory:"), 0);
      ((void (*)(id, SEL, BOOL, long))objc_msgSend)(v, sel_getUid("setRounded:iconSize:"), YES, n);
      [v setValue:@YES forKey:@"showsInlineChargingIndicator"];
      [v setValue:@(mode > 0) forKey:@"showsPercentage"];
      [v setValue:@0.5 forKey:@"chargePercent"];
      [v setValue:@(mode == 2 ? 1 : 0) forKey:@"chargingState"];
      v.frame = (CGRect){CGPointZero, v.intrinsicContentSize};
      [v layoutIfNeeded]; }];
    } @catch (NSException *e) { printf("iconSize %ld: %s\n", n, e.reason.UTF8String); break; }
    UITraitCollection *t = v.traitCollection;
    CGSize bs = ((CGSize (*)(id, SEL, id))objc_msgSend)(v, sel_getUid("_batterySizeForTraitCollection:"), t);
    CGSize ps = ((CGSize (*)(id, SEL, id))objc_msgSend)(v, sel_getUid("_pinSizeForTraitCollection:"), t);
    CALayer *pin = [v valueForKey:@"pinLayer"], *bolt = [v valueForKey:@"boltLayer"];
    UILabel *lb = [v valueForKey:@"percentageLabel"];
    if (mode == 0)
      printf("\niconSize %2ld: battery=%.4fx%.4f pin=%.4fx%.4f pinX=%.4f intrinsic=%.4fx%.4f lw=%.4f outR=%.4f inR=%.4f roundedFactor=%.4f font=%.4f condensed=%d vAdj=%.4f xAdjFull=%.4f boltMult=%.4f pctBoltMult=%.4f boltPos=%.4f\n",
        n, bs.width, bs.height, ps.width, ps.height, pin.frame.origin.x, v.bounds.size.width, v.bounds.size.height,
        D(v, "_lineWidthAndInterspaceForTraitCollection:"), D(v, "_outsideCornerRadiusForTraitCollection:"), D(v, "_insideCornerRadiusForTraitCollection:"),
        ([v respondsToSelector:sel_getUid("_roundedCornerRadiusFactor")] ? ((double (*)(id, SEL))objc_msgSend)(v, sel_getUid("_roundedCornerRadiusFactor")) : NAN), D(v, "_percentageFontSizeForTraitCollection:"),
        ((BOOL (*)(id, SEL, id))objc_msgSend)(v, sel_getUid("_percentageFontCondensedWhenChargingForTraitCollection:"), t),
        D(v, "_percentTextVerticalAdjustmentForTraitCollection:"), D(v, "_percentTextXAdjustmentWhenFullForTraitCollection:"),
        ((double (*)(id, SEL))objc_msgSend)(v, sel_getUid("_batteryBoltScaleFactorMultiplier")),
        ((double (*)(id, SEL))objc_msgSend)(v, sel_getUid("_percentageBatteryBoltScaleFactorMultiplier")),
        D(v, "_batteryBoltPositionOffsetForTraitCollection:"));
    CALayer *fillL = [v valueForKey:@"percentFillLayer"];
    printf("   fill=%s\n", NSStringFromCGRect(fillL.frame).UTF8String);
    printf("   mode%d size=%.4fx%.4f pinFrame=%s bolt=%s hidden=%d op=%.0f scale=%.4f label=%s \"%s\" %s %.3f\n", mode, v.bounds.size.width, v.bounds.size.height,
      NSStringFromCGRect(pin.frame).UTF8String, NSStringFromCGRect(bolt.frame).UTF8String, bolt.hidden, bolt.opacity, bolt.affineTransform.a,
      lb ? NSStringFromCGRect(lb.frame).UTF8String : "-", lb.text.UTF8String ?: "", lb.font.fontName.UTF8String ?: "", lb.font.pointSize);
  }
} return 0; }
