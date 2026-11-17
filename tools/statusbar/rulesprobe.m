// Compare iOS 27 reconstruction against native methods, including boundaries.
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import "../providers/ProviderRules27.h"
#import "WifiIcon27.h"
@interface AuditExclusion:NSObject
@property CGRect rect;
@end
@implementation AuditExclusion
@end
@interface AuditScreen:NSObject
@property double scaleValue,nativeScaleValue;
@property CGRect referenceBounds;
@property id exclusion;
@end
@implementation AuditScreen
-(double)_scale{return self.scaleValue;}
-(double)_nativeScale{return self.nativeScaleValue;}
-(CGRect)_unjailedReferenceBounds{return self.referenceBounds;}
-(id)_exclusionArea{return self.exclusion;}
@end
@interface AuditBar:NSObject
@property id screen;
@end
@implementation AuditBar
-(id)_effectiveTargetScreen{return self.screen;}
@end
@interface AuditInput:NSObject
@property double scaleValue;
@property id statusBar;
@end
@implementation AuditInput
-(double)normalIconScale{return self.scaleValue;}
-(double)expandedIconScale{return self.scaleValue;}
@end
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    if(![UIDevice.currentDevice.systemVersion hasPrefix:@"27."]){fprintf(stderr,"iOS 27 only\n");return 2;}
    NSMutableArray *selection=[NSMutableArray array],*mapping=[NSMutableArray array],*wifi=[NSMutableArray array];
    AuditScreen *screen=[AuditScreen new];AuditExclusion *exclusion=[AuditExclusion new];screen.exclusion=exclusion;
    Class dynamic=NSClassFromString(@"STUIStatusBarVisualProvider_DynamicSplit");SEL select=sel_getUid("visualProviderSubclassForScreen:visualProviderInfo:");
    for(NSNumber *width in @[@393,@401.999,@402,@402.001,@440])for(NSNumber *cutout in @[@125,@284.999,@285,@285.001,@375])for(NSNumber *scale in @[@2,@3,@3.3]){
        screen.referenceBounds=CGRectMake(0,0,width.doubleValue,874);screen.scaleValue=scale.doubleValue;screen.nativeScaleValue=3;exclusion.rect=CGRectMake(0,34,cutout.doubleValue,110);
        Class chosen=((Class(*)(id,SEL,id,id))objc_msgSend)(dynamic,select,screen,nil);
        NSString *actual=NSStringFromClass(chosen),*expected=PR27DynamicProvider(width.doubleValue,3,scale.doubleValue,cutout.doubleValue);
        NSCAssert([actual isEqual:expected],@"selection mismatch");[selection addObject:@{@"referenceWidth":width,@"scale":scale,@"nativeScale":@3,@"exclusionWidth":cutout,@"actual":actual,@"expected":expected}];
    }
    AuditBar *bar=[AuditBar new];bar.screen=screen;AuditInput *input=[AuditInput new];input.statusBar=bar;
    for(NSString *name in @[@"normalIconSize",@"expandedIconSize"]){SEL sel=NSSelectorFromString(name);IMP imp=class_getMethodImplementation(NSClassFromString(@"STUIStatusBarVisualProvider_Split"),sel);
        for(NSNumber *scale in @[@2,@2.5,@2.500001,@3])for(NSNumber *value in @[@1,@1.06,@1.07,@1.08,@1.12,@1.18,@1.26,@1.32,@1.16,@1.2412,@1.2992000000000001,@1.1800001]){
            screen.scaleValue=scale.doubleValue;input.scaleValue=value.doubleValue;
            NSInteger actual=((NSInteger(*)(id,SEL))imp)(input,sel),expected=PR27IconSize(value.doubleValue,scale.doubleValue);
            NSCAssert(actual==expected,@"mapping mismatch");[mapping addObject:@{@"method":name,@"scale":scale,@"iconScale":value,@"actual":@(actual),@"expected":@(expected)}];
        }
    }
    Class w=NSClassFromString(@"STUIStatusBarWifiSignalIconView");
    CGFloat wifiError=0;
    for(NSInteger i=1;i<=19;i++){
        NSMutableDictionary *row=[@{@"iconSize":@(i)}mutableCopy];
        for(NSString *s in @[@"_totalWidthFor:",@"_totalHeightFor:",@"_pointSizeFor:",@"_verticalOffsetFor:"])
            row[s]=@(((CGFloat(*)(id,SEL,NSInteger))objc_msgSend)(w,NSSelectorFromString(s),i));
        row[@"_weightFor:"]=@(((NSInteger(*)(id,SEL,NSInteger))objc_msgSend)(w,sel_getUid("_weightFor:"),i));
        Wifi27Spec expected=Wifi27Specification(i);CGFloat values[]={expected.width,expected.height,expected.pointSize,expected.offset,expected.weight};
        NSArray *keys=@[@"_totalWidthFor:",@"_totalHeightFor:",@"_pointSizeFor:",@"_verticalOffsetFor:",@"_weightFor:"];
        for(int j=0;j<5;j++)wifiError=MAX(wifiError,fabs([row[keys[j]]doubleValue]-values[j]));[wifi addObject:row];
    }
    NSCAssert(wifiError<1e-9,@"Wi-Fi table mismatch");
    NSMutableArray *cell=[NSMutableArray array];Class c=NSClassFromString(@"STUIStatusBarCellularSignalView");
    for(NSInteger i=1;i<=19;i++){
        NSMutableDictionary *row=[@{@"iconSize":@(i)}mutableCopy];
        for(NSString *s in @[@"_barWidthForIconSize:",@"_barCornerRadiusForIconSize:",@"_interspaceForIconSize:",@"_verticalOffsetForIconSize:"])
            row[s]=@(((CGFloat(*)(id,SEL,NSInteger))objc_msgSend)(c,NSSelectorFromString(s),i));
        NSMutableArray *heights=[NSMutableArray array];for(NSInteger j=0;j<4;j++)[heights addObject:@(((CGFloat(*)(id,SEL,NSInteger,NSInteger))objc_msgSend)(c,sel_getUid("_heightForNormalBarAtIndex:iconSize:"),j,i))];
        row[@"heights"]=heights;[cell addObject:row];
    }
    id real=UIScreen.mainScreen;id area=((id(*)(id,SEL))objc_msgSend)(real,sel_getUid("_exclusionArea"));CGRect rect=((CGRect(*)(id,SEL))objc_msgSend)(area,sel_getUid("rect"));
    NSDictionary *out=@{@"version":UIDevice.currentDevice.systemVersion,@"model":@(getenv("SIMULATOR_MODEL_IDENTIFIER")?:"unknown"),@"actualExclusionRect":NSStringFromCGRect(rect),@"dynamicSelection":selection,@"iconSizeMapping":mapping,@"wifiIconParameters":wifi,@"wifiMaxParameterError":@(wifiError),@"cellularParameters":cell};
    [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:@(argv[1])atomically:YES];
    printf("%lu selection + %lu mapping native comparisons PASS; 19 Wi-Fi icon parameter rows\n",(unsigned long)selection.count,(unsigned long)mapping.count);
}return 0;}
