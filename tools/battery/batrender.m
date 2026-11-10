// 电池图标的独立重绘：只用还原出的规则和路径，不调用 _UIBatteryView 的绘制逻辑。
// 唯一借用系统的是百分比数字的字体对象（字体不在还原范围内）。
// 用法：batrender <17|27> <输出目录> <标签> <电量0-1> <chargingState> <saver> <showsPercentage> ...（每 5 个参数一组）
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <dlfcn.h>

typedef struct {
    int ver;                 // 17 或 27
    CGFloat W, H, lw;        // 外壳尺寸、线宽（= 外壳与凸头的间距）
    CGSize pin;
    CGFloat vAdj, xAdjFull;  // 百分比文字的垂直微调、满电时水平微调
    CGFloat boltMult, pctBoltMult;
} Spec;

// 状态栏实测的 iconSize：iOS 17.4 iPhone 15 Pro = 7，iOS 27 iPhone 17 Pro = 8
static Spec spec(int ver) {
    if (ver == 27) return (Spec){27, 79 / 3.0, 41 / 3.0, 0.75, {2, 5}, 1 / 3.0, 1 / 3.0, 1.18840579710145, 0.75072463768116};
    return (Spec){17, 25, 13, 1, {4 / 3.0, 4.5}, 1 / 3.0, 1 / 3.0, 1.13043478260870, 0.71014492753623};
}

static const CGFloat kScale = 3;
static CGFloat px(CGFloat v) { return round(v * kScale) / kScale; }   // UIRoundToViewScale

// +[_UIBatteryView _boltBezierPathForSize:]，32×40 坐标系（iOS 17.4 与 27 相同）
static UIBezierPath *boltPath(void) {
    UIBezierPath *p = [UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(12.4290, 37.0230)];
    [p addLineToPoint:CGPointMake(27.2720, 19.1520)];
    [p addCurveToPoint:CGPointMake(27.7380, 18.0340) controlPoint1:CGPointMake(27.5830, 18.7790) controlPoint2:CGPointMake(27.7380, 18.4220)];
    [p addCurveToPoint:CGPointMake(26.4180, 16.7920) controlPoint1:CGPointMake(27.7380, 17.3040) controlPoint2:CGPointMake(27.1790, 16.7920)];
    [p addLineToPoint:CGPointMake(17.2580, 16.7920)];
    [p addLineToPoint:CGPointMake(22.0240, 4.3090)];
    [p addCurveToPoint:CGPointMake(19.5710, 2.9740) controlPoint1:CGPointMake(22.7380, 2.4770) controlPoint2:CGPointMake(20.8130, 1.4830)];
    [p addLineToPoint:CGPointMake(4.7280, 20.8440)];
    [p addCurveToPoint:CGPointMake(4.2620, 21.9780) controlPoint1:CGPointMake(4.4170, 21.2170) controlPoint2:CGPointMake(4.2620, 21.5740)];
    [p addCurveToPoint:CGPointMake(5.5820, 23.2200) controlPoint1:CGPointMake(4.2620, 22.6920) controlPoint2:CGPointMake(4.8210, 23.2200)];
    [p addLineToPoint:CGPointMake(14.7420, 23.2200)];
    [p addLineToPoint:CGPointMake(9.9760, 35.6880)];
    [p addCurveToPoint:CGPointMake(12.4290, 37.0230) controlPoint1:CGPointMake(9.2620, 37.5350) controlPoint2:CGPointMake(11.1870, 38.5130)];
    [p closePath];
    return p;
}

// +[_UIBatteryView _boltMaskBezierPath]：闪电外扩一圈，用来在外壳和填充上挖洞
static UIBezierPath *boltMaskPath(void) {
    UIBezierPath *p = [UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(27.8280, -2.5000)];
    [p addLineToPoint:CGPointMake(20.1720, -2.5000)];
    [p addLineToPoint:CGPointMake(17.2860, 0.9480)];
    [p addLineToPoint:CGPointMake(2.3510, 18.9290)];
    [p addCurveToPoint:CGPointMake(1.1880, 21.9900) controlPoint1:CGPointMake(1.5790, 19.8560) controlPoint2:CGPointMake(1.1880, 20.8860)];
    [p addCurveToPoint:CGPointMake(5.5170, 26.2400) controlPoint1:CGPointMake(1.1880, 24.3730) controlPoint2:CGPointMake(3.0900, 26.2400)];
    [p addLineToPoint:CGPointMake(10.3760, 26.2400)];
    [p addLineToPoint:CGPointMake(7.1400, 34.7050)];
    [p addLineToPoint:CGPointMake(4.1800, 42.5000)];
    [p addLineToPoint:CGPointMake(11.8340, 42.5000)];
    [p addLineToPoint:CGPointMake(14.7140, 39.0480)];
    [p addLineToPoint:CGPointMake(29.6480, 21.0670)];
    [p addCurveToPoint:CGPointMake(30.8130, 18.0210) controlPoint1:CGPointMake(30.4210, 20.1400) controlPoint2:CGPointMake(30.8130, 19.1150)];
    [p addCurveToPoint:CGPointMake(26.4840, 13.7710) controlPoint1:CGPointMake(30.8130, 15.6380) controlPoint2:CGPointMake(28.9120, 13.7710)];
    [p addLineToPoint:CGPointMake(21.6230, 13.7710)];
    [p addLineToPoint:CGPointMake(24.8580, 5.2990)];
    [p addLineToPoint:CGPointMake(27.8280, -2.5000)];
    [p closePath];
    return p;
}

// +[_UIBatteryView _pinBezierPathForSize:isComplex:NO]：半径 h/2 的圆，在 x = 0 处切开
static UIBezierPath *pinPath(CGSize s) {
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGFloat r = s.height / 2, d = r - s.width, a = acos(d / r);
    [p moveToPoint:CGPointMake(0, r - sqrt(r * r - d * d))];
    [p addArcWithCenter:CGPointMake(-d, r) radius:r startAngle:a endAngle:-a clockwise:NO];
    [p closePath];
    return p;
}

// 把 32×40 坐标系的闪电/蒙版放到以 center 为中心、缩放 k 的位置
static UIBezierPath *placed(UIBezierPath *src, CGPoint center, CGFloat k) {
    UIBezierPath *p = [src copy];
    [p applyTransform:CGAffineTransformMakeTranslation(-16, -20)];
    [p applyTransform:CGAffineTransformMakeScale(k, k)];
    [p applyTransform:CGAffineTransformMakeTranslation(center.x, center.y)];
    return p;
}

static UIColor *rgb(CGFloat r, CGFloat g, CGFloat b) { return [UIColor colorWithRed:r green:g blue:b alpha:1]; }

int main(int argc, char **argv) {
    @autoreleasepool {
        dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI", RTLD_NOW);
        int ver = atoi(argv[1]);
        NSString *outDir = @(argv[2]);
        Spec S = spec(ver);
        for (int i = 3; i + 4 < argc; i += 5) {
            NSString *tag = @(argv[i]);
            double p = atof(argv[i + 1]);
            long state = atol(argv[i + 2]);
            BOOL saver = atoi(argv[i + 3]) != 0, pct = atoi(argv[i + 4]) != 0;

            // ---- 尺寸 ----
            CGFloat W = S.W, H = S.H + (pct ? 2 / kScale : 0), lw = S.lw;        // 显示百分比时高度 + 2/scale
            CGRect bounds = CGRectMake(0, 0, W + lw + S.pin.width, H);
            // 外壳矩形：iOS 27 不内缩；17.4 无百分比时内缩半个线宽（描边）
            CGRect body = (S.ver == 17 && !pct) ? CGRectInset(CGRectMake(0, 0, W, H), lw / 2, lw / 2) : CGRectMake(0, 0, W, H);
            CGFloat bodyR = body.size.height / 3.125;                               // rounded 模式
            CGRect pinRect = CGRectMake(W + lw, CGRectGetMidY(bounds) - S.pin.height / 2, S.pin.width, S.pin.height);

            // ---- 状态 ----
            BOOL low = p <= 0.2;
            BOOL showBolt = state != 0 && (!pct || p < 0.995);
            BOOL boltInactive = state > 2;
            BOOL cutout = !saver && (state == 0 || state == 4) && !low;           // _batteryTextIsCutout

            // ---- 颜色（浅色外观）----
            UIColor *label = UIColor.blackColor;
            UIColor *fillColor = saver ? rgb(1, 0.8, 0) : low ? (S.ver == 27 ? rgb(1, 0.22, 0.235) : rgb(1, 0.231, 0.188))
                               : (state != 0 && state != 4) ? rgb(0.204, 0.78, 0.349) : label;
            UIColor *inactive = [label colorWithAlphaComponent:saver ? 0.2 : 0.3];
            UIColor *bodyColor, *pinColor;
            if (S.ver == 17 && !pct) { bodyColor = [label colorWithAlphaComponent:0.4]; pinColor = [label colorWithAlphaComponent:0.5]; }
            else bodyColor = pinColor = p >= 0.995 ? fillColor : inactive;      // _batteryUnfilledColor
            UIColor *textColor = saver ? UIColor.blackColor : UIColor.whiteColor;
            UIColor *boltColor = pct ? (boltInactive && !cutout ? [textColor colorWithAlphaComponent:0.6] : textColor)
                                     : (boltInactive ? [label colorWithAlphaComponent:0.3] : label);

            // ---- 填充 ----
            CGRect fill; CGFloat fillR;
            if (S.ver == 17 && !pct) {
                fill = CGRectInset(CGRectMake(0, 0, W, H), 2 * lw, 2 * lw);
                fillR = fill.size.height / 3.125;
                fill.size.width *= p;                                               // 先用未取整的宽度判断
                if (fill.size.width < 2 * fillR) {
                    CGFloat k = (fillR - fill.size.width / 2) / 2;
                    fill.origin.y += k; fill.size.height -= 2 * k; fillR = fill.size.width / 2;
                }
                fill.size.width = MAX(px(fill.size.width), 1);                      // 最后才取整、保底 1pt
            } else {
                fill = CGRectMake(0, 0, MAX(px(W * p), 1), H);
                fillR = H / 3.125;
            }

            // ---- 百分比文字（字体对象向系统要）----
            UILabel *lb = nil;
            CGPoint boltCenter = CGPointMake(CGRectGetMidX(body), CGRectGetMidY(body));
            CGFloat boltK = (2 / 3.0) * 0.5 * S.boltMult;                         // pathScale × large × multiplier
            if (pct) {
                UIView *sys = [[NSClassFromString(@"STUIStatusBarStaticBatteryView") alloc] initWithFrame:CGRectZero];
                ((void (*)(id, SEL, long))objc_msgSend)(sys, sel_getUid("setInternalSizeCategory:"), 0);
                ((void (*)(id, SEL, BOOL, long))objc_msgSend)(sys, sel_getUid("setRounded:iconSize:"), YES, S.ver == 27 ? 8 : 7);
                [sys setValue:@YES forKey:@"showsInlineChargingIndicator"];
                [sys setValue:@YES forKey:@"showsPercentage"];
                [sys setValue:@(p) forKey:@"chargePercent"];
                [sys setValue:@(state) forKey:@"chargingState"];
                [sys setValue:@(saver) forKey:@"saverModeActive"];
                UIFont *font = [[sys valueForKey:@"percentageLabel"] font];
                lb = [[UILabel alloc] init];
                lb.font = font;
                lb.text = [NSString localizedStringWithFormat:@"%.0f", MAX(p * 100, 1)];
                lb.textColor = textColor;
                [lb sizeToFit];
                // -[_UIBatteryView _updateLightningBoltAndPercentagePosition]
                CGFloat cy = CGRectGetMidY(body) + S.vAdj, cx;
                if (showBolt) {
                    CGFloat space = lw + lw + 2 / kScale + S.pctBoltMult * (1 / 3.0) * (32 / 3.0);
                    cx = CGRectGetMidX(body) - space * 0.5;
                } else {
                    cx = CGRectGetMidX(body);
                    if (p >= 0.995) cx += S.xAdjFull;
                }
                CGFloat ox = cx - lb.bounds.size.width * 0.5, oy = cy - lb.bounds.size.height * 0.5;
                cx = cx + (ox - px(ox));                                            // 系统这里是 +（水平方向）
                CGFloat cyLabel = cy - (oy - px(oy));                               // 垂直方向是 −
                lb.center = CGPointMake(cx, cyLabel);
                boltCenter = CGPointMake(CGRectGetMidX(body) + lb.frame.size.width * 0.5, cy);
                boltK = (2 / 3.0) * 0.5 * S.pctBoltMult;
            }

            // ---- 合成：和系统一样，每层先按自身尺寸渲染成位图（像素尺寸向上取整），再拉伸贴进图层 frame ----
            // 视图图层带滤镜，整体离屏合成，所以 destOut 只影响电池自身。
            UIImage *(^R)(CGSize, void (^)(CGContextRef)) = ^UIImage *(CGSize sz, void (^draw)(CGContextRef)) {
                UIGraphicsImageRendererFormat *ff = [UIGraphicsImageRendererFormat preferredFormat];
                ff.scale = kScale; ff.opaque = NO;
                return [[[UIGraphicsImageRenderer alloc] initWithSize:sz format:ff] imageWithActions:^(UIGraphicsImageRendererContext *c) { draw(c.CGContext); }];
            };
            CGRect viewBounds = CGRectMake(0, 0, px(bounds.size.width), bounds.size.height);   // 状态栏把视图宽度对齐到像素
            BOOL bakedCutout = !pct && showBolt;                                    // _useImagesWithCutoutsForBolt
            CGSize boltBox = CGSizeMake(32 * 2 / 3.0, 40 * 2 / 3.0);               // 闪电图层 bounds：路径尺寸 × pathScale
            CGFloat layerScale = boltK / (2 / 3.0);                                 // 图层 transform 缩放
            CGRect boltRect = CGRectMake(boltCenter.x - boltBox.width * layerScale / 2, boltCenter.y - boltBox.height * layerScale / 2,
                                         boltBox.width * layerScale, boltBox.height * layerScale);
            UIBezierPath *(^maskIn)(CGPoint) = ^UIBezierPath *(CGPoint origin) {   // 蒙版路径换到某张位图的坐标系
                UIBezierPath *m = placed(boltMaskPath(), boltCenter, boltK);
                [m applyTransform:CGAffineTransformMakeTranslation(-origin.x, -origin.y)];
                return m;
            };
            UIImage *bodyImg = R(viewBounds.size, ^(CGContextRef ctx) {
                UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:body cornerRadius:bodyR];
                [UIColor.blackColor set];
                if (S.ver == 17) { bp.lineWidth = pct ? 0 : lw; [bp stroke]; if (pct) [bp fill]; } else [bp fill];
                if (bakedCutout) [maskIn(CGPointZero) fillWithBlendMode:kCGBlendModeDestinationOut alpha:1];
            });
            UIImage *fillImg = R(fill.size, ^(CGContextRef ctx) {
                [UIColor.blackColor set];
                if (S.ver == 17 && !pct) [[UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointZero, fill.size} cornerRadius:fillR] fill];
                else {
                    UIBezierPath *fp = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, MAX(W, 2 * fillR), H) cornerRadius:fillR];
                    if (S.ver == 17) { fp.lineWidth = 0; [fp stroke]; }
                    [fp fill];
                }
                if (bakedCutout) [maskIn(fill.origin) fillWithBlendMode:kCGBlendModeDestinationOut alpha:1];
            });
            UIImage *pinImg = R(S.pin, ^(CGContextRef ctx) { [UIColor.blackColor set]; [pinPath(S.pin) fill]; });
            UIImage *boltImg = R(boltBox, ^(CGContextRef ctx) {
                [UIColor.blackColor set];
                UIBezierPath *b = boltPath(); [b applyTransform:CGAffineTransformMakeScale(2 / 3.0, 2 / 3.0)]; [b fill];
            });
            UIImage *labelImg = lb ? R(lb.bounds.size, ^(CGContextRef ctx) { [lb drawTextInRect:lb.bounds]; }) : nil;
            // contentsMultiplyColor：位图当作 alpha 蒙版，乘上颜色
            void (^tint)(CGContextRef, UIImage *, CGRect, UIColor *, CGBlendMode) = ^(CGContextRef ctx, UIImage *im, CGRect r, UIColor *col, CGBlendMode mode) {
                CGContextSaveGState(ctx);
                CGContextSetBlendMode(ctx, mode); CGContextSetInterpolationQuality(ctx, kCGInterpolationLow);  // 近似 Core Animation 的双线性过滤
                CGContextBeginTransparencyLayer(ctx, NULL);
                [im drawInRect:r];
                CGContextSetBlendMode(ctx, kCGBlendModeSourceIn);
                [col setFill]; CGContextFillRect(ctx, r);
                CGContextEndTransparencyLayer(ctx);
                CGContextRestoreGState(ctx);
            };
            UIGraphicsImageRendererFormat *f = [UIGraphicsImageRendererFormat preferredFormat];
            f.scale = kScale; f.opaque = NO;
            CGSize canvas = CGSizeMake(ceil(bounds.size.width), ceil(bounds.size.height));
            UIImage *img = [[[UIGraphicsImageRenderer alloc] initWithSize:canvas format:f] imageWithActions:^(UIGraphicsImageRendererContext *c) {
                CGContextRef ctx = c.CGContext;
                tint(ctx, bodyImg, viewBounds, bodyColor, kCGBlendModeNormal);
                tint(ctx, fillImg, fill, fillColor, kCGBlendModeNormal);
                tint(ctx, pinImg, pinRect, pinColor, kCGBlendModeNormal);
                if (lb) {
                    if (cutout) tint(ctx, labelImg, lb.frame, UIColor.blackColor, kCGBlendModeDestinationOut);
                    else [labelImg drawInRect:lb.frame];
                }
                if (showBolt) tint(ctx, boltImg, boltRect, pct && cutout ? UIColor.blackColor : boltColor,
                                   pct && cutout ? kCGBlendModeDestinationOut : kCGBlendModeNormal);
            }];
            [UIImagePNGRepresentation(img) writeToFile:[outDir stringByAppendingFormat:@"/%@.png", tag] atomically:YES];
            printf("%s %s fill=%s label=%s bolt=(%.4f,%.4f)x%.4f\n", tag.UTF8String, NSStringFromCGRect(bounds).UTF8String,
                   NSStringFromCGRect(fill).UTF8String, lb ? NSStringFromCGRect(lb.frame).UTF8String : "-", boltCenter.x, boltCenter.y, boltK);
        }
    }
    return 0;
}
