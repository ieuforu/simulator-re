#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

static NSArray *SRRect(CGRect r) { return @[@(r.origin.x),@(r.origin.y),@(r.size.width),@(r.size.height)]; }
static NSArray *SRSize(CGSize s) { return @[@(s.width),@(s.height)]; }
static id SRValue(id o, NSString *key) {
    @try {
        id v = [o valueForKey:key];
        if (!v) return NSNull.null;
        return [v isKindOfClass:NSNumber.class] || [v isKindOfClass:NSString.class] ? v : [v description];
    } @catch (id e) { return NSNull.null; }
}
static NSArray *SRColor(CGColorRef c) {
    CGFloat r=0,g=0,b=0,a=0;
    if (!c || ![[UIColor colorWithCGColor:c] getRed:&r green:&g blue:&b alpha:&a]) return @[];
    return @[@(r),@(g),@(b),@(a)];
}
static void SRPathElement(void *info, const CGPathElement *e) {
    int counts[] = {1,1,2,3,0};
    NSMutableArray *points = [NSMutableArray array];
    for (int i=0;i<counts[e->type];i++) [points addObject:@[@(e->points[i].x),@(e->points[i].y)]];
    [(__bridge NSMutableArray *)info addObject:@{@"op":@[@"M",@"L",@"Q",@"C",@"Z"][e->type],@"points":points}];
}
static NSDictionary *SRLayer(CALayer *l, NSString *dir, NSString *stem, NSUInteger *index) {
    NSMutableDictionary *out = [@{@"class":NSStringFromClass(l.class),@"frame":SRRect(l.frame),@"bounds":SRRect(l.bounds),
        @"position":@[@(l.position.x),@(l.position.y)],@"opacity":@(l.opacity),@"hidden":@(l.hidden),
        @"cornerRadius":@(l.cornerRadius),@"cornerCurve":l.cornerCurve,@"contentsScale":@(l.contentsScale),
        @"backgroundColor":SRColor(l.backgroundColor)} mutableCopy];
    if (l.compositingFilter) out[@"compositingFilter"] = [l.compositingFilter description];
    if ([l isKindOfClass:CAShapeLayer.class]) {
        CAShapeLayer *s=(id)l; NSMutableArray *p=[NSMutableArray array];
        if(s.path)CGPathApply(s.path,(__bridge void *)p,SRPathElement);
        out[@"path"]=p; out[@"lineWidth"]=@(s.lineWidth);out[@"fillColor"]=SRColor(s.fillColor);out[@"strokeColor"]=SRColor(s.strokeColor);
    }
    if(l.contents && CFGetTypeID((__bridge CFTypeRef)l.contents)==CGImageGetTypeID()) {
        CGImageRef im=(__bridge CGImageRef)l.contents;
        NSString *name=[NSString stringWithFormat:@"%@-layer%02lu.png",stem,(unsigned long)++*index];
        [UIImagePNGRepresentation([UIImage imageWithCGImage:im]) writeToFile:[dir stringByAppendingPathComponent:name] atomically:YES];
        out[@"image"]=name;out[@"imagePixels"]=@[@(CGImageGetWidth(im)),@(CGImageGetHeight(im))];
    }
    NSMutableArray *children=[NSMutableArray array];
    for(CALayer *child in l.sublayers)[children addObject:SRLayer(child,dir,stem,index)];
    out[@"children"]=children;
    return out;
}
static NSDictionary *SRView(UIView *v, NSString *dir, NSString *stem) {
    NSMutableDictionary *out=[@{@"class":NSStringFromClass(v.class),@"frame":SRRect(v.frame),@"bounds":SRRect(v.bounds),
        @"hidden":@(v.hidden),@"alpha":@(v.alpha),@"intrinsicSize":SRSize(v.intrinsicContentSize)} mutableCopy];
    if(v.window)out[@"screenFrame"]=SRRect([v convertRect:v.bounds toCoordinateSpace:v.window.screen.coordinateSpace]);
    for(NSString *key in @[@"rounded",@"iconSize",@"signalMode",@"numberOfBars",@"numberOfActiveBars",@"smallSize",@"needsLargerScale",@"activeColor",@"inactiveColor",@"showsPercentage"])
        out[key]=SRValue(v,key);
    if([v respondsToSelector:sel_getUid("_barCornerRadius")])out[@"barCornerRadius"]=@(((CGFloat(*)(id,SEL))objc_msgSend)(v,sel_getUid("_barCornerRadius")));
    NSUInteger i=0;out[@"layer"]=SRLayer(v.layer,dir,stem,&i);
    return out;
}
