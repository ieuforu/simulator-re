// 根据 iOS 17.4 SystemStatusUI 反汇编和参数表手工还原，不调用私有图标绘制方法。
#import <UIKit/UIKit.h>
typedef struct { NSInteger size; CGFloat cellWidth,cellGap,cellRadius,heights[4],wifiWidth,wifiHeight,wifiGap,thickness[3],wifiCorner; } SRSpec;
static SRSpec SRSpecification(NSInteger n) {
    if(n==4)return (SRSpec){4,3,5/3.0,1,{4,6,26/3.0,34/3.0},50/3.0,12,1.75,{3.5,29/12.0,29/12.0},2/3.0};
    if(n==7)return (SRSpec){7,10/3.0,2,7/6.0,{14/3.0,7,29/3.0,37/3.0},17,37/3.0,1.75,{23/6.0,2.5,2.5},2/3.0};
    return (SRSpec){8,11/3.0,7/3.0,1.2,{16/3.0,23/3.0,32/3.0,41/3.0},59/3.0,14,23/12.0,{13/3.0,17/6.0,17/6.0},2/3.0};
}
// 构造一条 Wi-Fi 带。thickness 是减去描边宽度后的几何厚度；corner 是描边线宽。
static UIBezierPath *SRWifiBand(CGSize size, CGFloat distance, CGFloat angle, CGPoint center, CGFloat corner, CGFloat thickness, BOOL rounded) {
    CGPoint (^left)(CGFloat)=^CGPoint(CGFloat r){return CGPointMake(center.x-r*cos(angle),size.height-r*sin(angle)-corner/2);};
    CGPoint (^mirror)(CGPoint)=^CGPoint(CGPoint p){return CGPointMake(size.width-p.x,p.y);};
    UIBezierPath *p;
    if(rounded && distance==0) {
        p=[UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x,center.y-thickness/2) radius:thickness/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    } else {
        p=[UIBezierPath bezierPath];[p moveToPoint:left(distance)];
        [p addArcWithCenter:center radius:distance startAngle:M_PI+angle endAngle:2*M_PI-angle clockwise:YES];
        distance+=rounded?thickness/2:thickness;
        CGPoint right=mirror(left(distance));
        if(rounded) {
            [p addArcWithCenter:right radius:thickness/2 startAngle:M_PI-angle endAngle:2*M_PI-angle clockwise:NO];
            distance+=thickness/2;
        } else [p addLineToPoint:right];
        [p addArcWithCenter:center radius:distance startAngle:2*M_PI-angle endAngle:M_PI+angle clockwise:NO];
        if(rounded)[p addArcWithCenter:left(distance-thickness/2) radius:thickness/2 startAngle:M_PI+angle endAngle:angle clockwise:NO];
        else p.lineJoinStyle=kCGLineJoinRound;
    }
    p.lineWidth=corner;[p closePath];return p;
}
static UIImage *SRWifiBandImage(SRSpec s,NSInteger index,BOOL rounded,CGFloat scale) {
    CGFloat distance=0;for(NSInteger i=0;i<index;i++)distance+=s.thickness[i]+s.wifiGap;
    CGFloat thickness=s.thickness[index]-s.wifiCorner;
    CGFloat angle=acos((s.wifiWidth/2)/s.wifiHeight);
    if(rounded)angle+=atan((thickness/2)/s.wifiHeight);
    CGSize size=CGSizeMake(s.wifiWidth,s.wifiHeight);
    CGPoint center=CGPointMake(s.wifiWidth/2,s.wifiHeight-s.wifiCorner/2);
    UIGraphicsImageRendererFormat *format=[UIGraphicsImageRendererFormat preferredFormat];
    format.scale=scale;format.opaque=NO;format.preferredRange=UIGraphicsImageRendererFormatRangeStandard;
    return [[[UIGraphicsImageRenderer alloc]initWithSize:size format:format]imageWithActions:^(UIGraphicsImageRendererContext *context){
        [UIColor.blackColor set];UIBezierPath *p=SRWifiBand(size,distance,angle,center,s.wifiCorner,thickness,rounded);[p fill];[p stroke];
    }];
}
static CALayer *SRCellularLayer(SRSpec s,BOOL rounded,NSInteger active) {
    CGFloat width=4*s.cellWidth+3*s.cellGap,height=s.heights[3];
    CALayer *root=[CALayer layer];root.frame=CGRectMake(0,0,width,height);
    for(NSInteger i=0;i<4;i++) {
        CALayer *bar=[CALayer layer];bar.frame=CGRectMake(i*(s.cellWidth+s.cellGap),height-s.heights[i],s.cellWidth,s.heights[i]);
        bar.cornerCurve=kCACornerCurveContinuous;bar.cornerRadius=rounded?s.cellWidth/2:s.cellRadius;
        bar.backgroundColor=[UIColor.blackColor colorWithAlphaComponent:i<active?1:0.2].CGColor;[root addSublayer:bar];
    }
    return root;
}
static UIImage *SRRenderLayer(CALayer *layer,CGFloat scale) {
    UIGraphicsImageRendererFormat *f=[UIGraphicsImageRendererFormat preferredFormat];f.scale=scale;f.opaque=NO;f.preferredRange=UIGraphicsImageRendererFormatRangeStandard;
    return [[[UIGraphicsImageRenderer alloc]initWithSize:layer.bounds.size format:f]imageWithActions:^(UIGraphicsImageRendererContext *c){[layer renderInContext:c.CGContext];}];
}
