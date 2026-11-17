#import "../signals/SignalDump.h"
#import "Cellular27.h"
#import <dlfcn.h>
static BOOL reverseLayout;
static BOOL Reverse(id self,SEL cmd){return reverseLayout;}
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    if(![UIDevice.currentDevice.systemVersion hasPrefix:@"27."])return 2;
    Class cls=objc_allocateClassPair(NSClassFromString(@"STUIStatusBarCellularSignalView"),"AuditCellularView",0);
    class_addMethod(cls,sel_getUid("_shouldReverseLayoutDirection"),(IMP)Reverse,"B@:");objc_registerClassPair(cls);
    NSMutableArray *cases=[NSMutableArray array];double worst=0;
    for(NSNumber *number in @[@4,@7,@8,@9,@10,@12])for(int rounded=0;rounded<2;rounded++)for(int reverse=0;reverse<2;reverse++)for(int active=0;active<=4;active++){
        reverseLayout=reverse;NSInteger n=number.integerValue;Cell27Spec s=Cell27Specification(n);UIView *v=[[cls alloc]initWithFrame:CGRectZero];
        [UIView performWithoutAnimation:^{
            [v setValue:number forKey:@"iconSize"];[v setValue:@(rounded) forKey:@"rounded"];
            [v setValue:@4 forKey:@"numberOfBars"];[v setValue:@2 forKey:@"signalMode"];
            [v setValue:@(active) forKey:@"numberOfActiveBars"];
            [v setValue:UIColor.blackColor forKey:@"activeColor"];[v setValue:[UIColor.blackColor colorWithAlphaComponent:0.25] forKey:@"inactiveColor"];
            ((void(*)(id,SEL))objc_msgSend)(v,sel_getUid("_iconSizeDidChange"));
            v.frame=(CGRect){CGPointZero,v.intrinsicContentSize};[v setNeedsLayout];[v layoutIfNeeded];
        }];
        if(v.layer.sublayers.count!=4)return 1;double error=0;
        for(int i=0;i<4;i++){
            CALayer *bar=v.layer.sublayers[i];CGRect expected=Cell27Frame(s,v.bounds.size,i,reverse);
            NSArray *a=SRRect(bar.frame),*b=SRRect(expected);for(int j=0;j<4;j++)error=MAX(error,fabs([a[j]doubleValue]-[b[j]doubleValue]));
            error=MAX(error,fabs(bar.cornerRadius-Cell27Radius(s,rounded)));
            error=MAX(error,fabs(CGColorGetAlpha(bar.backgroundColor)-(i<active?1:.25)));
            if(![bar.cornerCurve isEqual:kCACornerCurveContinuous])return 1;
        }
        worst=MAX(worst,error);[cases addObject:@{@"iconSize":number,@"rounded":@(rounded),@"forcedReverseBranch":@(reverse),@"activeBars":@(active),@"maxGeometryOrAlphaError":@(error)}];
    }
    NSDictionary *out=@{@"version":UIDevice.currentDevice.systemVersion,@"scope":@"six sizes; native layer frames, continuous corner settings and alpha; forced reverse branch, not whole-system RTL validation",@"cases":cases,@"worstError":@(worst)};
    [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:@(argv[1])atomically:YES];
    printf("%lu cellular cases / %lu bars: worst error %.3g\n",(unsigned long)cases.count,(unsigned long)cases.count*4,worst);return worst>1e-9?1:0;
}}
