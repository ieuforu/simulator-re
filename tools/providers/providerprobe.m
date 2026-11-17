// Run inside an experiment Simulator. Native selectors are the test oracle;
// synthetic screens isolate branch conditions without changing device settings.
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import "ProviderRules.h"
static id Obj(id x,const char *s){return ((id(*)(id,SEL))objc_msgSend)(x,sel_getUid(s));}
static double Num(id x,const char *s){return ((double(*)(id,SEL))objc_msgSend)(x,sel_getUid(s));}
static CGRect PRRect(id x,const char *s){return ((CGRect(*)(id,SEL))objc_msgSend)(x,sel_getUid(s));}
static NSArray *Box(CGRect r){return @[@(r.origin.x),@(r.origin.y),@(r.size.width),@(r.size.height)];}
static NSString *Select(NSString *cls,id screen){Class c=((Class(*)(id,SEL,id,id))objc_msgSend)(NSClassFromString(cls),sel_getUid("visualProviderSubclassForScreen:visualProviderInfo:"),screen,nil);return c?NSStringFromClass(c):@"nil";}
@interface PRExclusion:NSObject
@property CGRect rect;
@end
@implementation PRExclusion
@end
@interface PRScreen:NSObject
@property double scaleValue,nativeScaleValue;
@property CGRect referenceBounds,nativeBounds;
@property id exclusion;
@end
@implementation PRScreen
-(double)_scale{return self.scaleValue;}
-(double)_nativeScale{return self.nativeScaleValue;}
-(CGRect)_unjailedReferenceBounds{return self.referenceBounds;}
-(CGRect)_nativeDisplayBounds{return self.nativeBounds;}
-(id)_exclusionArea{return self.exclusion;}
-(id)traitCollection{return [UITraitCollection traitCollectionWithUserInterfaceIdiom:UIUserInterfaceIdiomPhone];}
@end
@interface PRStatus:NSObject
@property id screen;
@end
@implementation PRStatus
-(id)_effectiveTargetScreen{return self.screen;}
@end
@interface PRScaleInput:NSObject
@property double scaleValue;
@property id statusBar;
@end
@implementation PRScaleInput
-(double)normalIconScale{return self.scaleValue;}
-(double)expandedIconScale{return self.scaleValue;}
@end
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    NSString *dir=@(argv[1]);[[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    id screen=UIScreen.mainScreen, exclusion=Obj(screen,"_exclusionArea");
    NSMutableDictionary *out=[@{@"systemVersion":UIDevice.currentDevice.systemVersion,@"model":@(getenv("SIMULATOR_MODEL_IDENTIFIER")?:"unknown"),
        @"screen":@{@"referenceBounds":Box(PRRect(screen,"_unjailedReferenceBounds")),@"nativeBounds":Box(PRRect(screen,"_nativeDisplayBounds")),
            @"displayInfoProviderClass":NSStringFromClass([Obj(screen,"_displayInfoProvider")class]),
            @"scale":@(Num(screen,"_scale")),@"nativeScale":@(Num(screen,"_nativeScale")),
            @"exclusionClass":exclusion?NSStringFromClass([exclusion class]):@"nil",@"exclusionRect":[exclusion respondsToSelector:sel_getUid("rect")]?Box(PRRect(exclusion,"rect")):@[]},
        @"selectedProvider":Select(@"STUIStatusBarVisualProvider_iOS",screen)} mutableCopy];
    NSMutableArray *candidates=[NSMutableArray array];NSMutableDictionary *addresses=[NSMutableDictionary dictionary];
    unsigned count=0;Class *classes=objc_copyClassList(&count);
    for(unsigned i=0;i<count;i++){
        NSString *name=NSStringFromClass(classes[i]);if(![name hasPrefix:@"STUIStatusBar"])continue;
        addresses[[NSString stringWithFormat:@"0x%llx",(unsigned long long)classes[i]]]=name;
        if(![name hasPrefix:@"STUIStatusBarVisualProvider_Split"]||![classes[i] respondsToSelector:sel_getUid("nativeDisplayWidth")])continue;
        CGSize notch=((CGSize(*)(id,SEL))objc_msgSend)(classes[i],sel_getUid("notchSize"));
        double width=Num(classes[i],"nativeDisplayWidth");
        BOOL hasReference=[classes[i]respondsToSelector:sel_getUid("referenceScreenScale")];double reference=hasReference?Num(classes[i],"referenceScreenScale"):3;
        PRScreen *fake=[PRScreen new];fake.scaleValue=reference;fake.nativeScaleValue=reference;fake.nativeBounds=CGRectMake(0,0,width,2500);fake.referenceBounds=CGRectMake(0,0,width/reference,800);
        PRExclusion *area=[PRExclusion new];area.rect=(CGRect){CGPointZero,notch};fake.exclusion=area;
        [candidates addObject:@{@"provider":name,@"nativeDisplayWidth":@(width),@"notchSize":@[@(notch.width),@(notch.height)],@"referenceScreenScale":hasReference?@(reference):(id)NSNull.null,@"syntheticSelected":Select(@"STUIStatusBarVisualProvider_Split",fake)}];
    }free(classes);
    out[@"notchCandidates"]=[candidates sortedArrayUsingComparator:^NSComparisonResult(id a,id b){return [a[@"provider"] compare:b[@"provider"]];}];
    NSMutableArray *notchTests=[NSMutableArray array];
    for(NSDictionary *c in candidates)for(NSNumber *native in @[@2.0,@3.0])for(NSString *change in @[@"exact",@"widthInsideTolerance",@"widthOutsideTolerance",@"notchHeightMismatch"]){
        double reference=[c[@"referenceScreenScale"]isKindOfClass:NSNumber.class]?[c[@"referenceScreenScale"]doubleValue]:3;
        double ratio=native.doubleValue/reference,width=[c[@"nativeDisplayWidth"]doubleValue];
        NSArray *sz=c[@"notchSize"];double nw=[sz[0]doubleValue]/ratio,nh=[sz[1]doubleValue]/ratio;
        if([change isEqual:@"widthInsideTolerance"])width+=0.00005;
        if([change isEqual:@"widthOutsideTolerance"])width+=0.0002;
        if([change isEqual:@"notchHeightMismatch"])nh+=0.0002/ratio;
        PRScreen *screen=[PRScreen new];screen.scaleValue=3;screen.nativeScaleValue=native.doubleValue;screen.nativeBounds=CGRectMake(0,0,width,2500);
        PRExclusion *area=[PRExclusion new];area.rect=CGRectMake(0,0,nw,nh);screen.exclusion=area;
        NSString *actual=Select(@"STUIStatusBarVisualProvider_Split",screen),*expected=PRNotchProvider(width,nw,nh,native.doubleValue,3);
        NSCAssert([actual isEqual:expected],@"notch selection mismatch");
        [notchTests addObject:@{@"candidate":c[@"provider"],@"case":change,@"nativeWidth":@(width),@"notchSize":@[@(nw),@(nh)],@"nativeScale":native,@"screenScale":@3,@"actual":actual,@"expected":expected}];
    }
    out[@"notchSelectionTests"]=notchTests;
    NSMutableArray *phoneTests=[NSMutableArray array];
    for(id y in @[@(-0.001),@0,@0.001,@(34/3.0),NSNull.null]){
        PRScreen *screen=[PRScreen new];screen.scaleValue=3;screen.nativeScaleValue=3;screen.nativeBounds=CGRectMake(0,0,1170,2532);screen.referenceBounds=CGRectMake(0,0,390,844);
        if(y!=NSNull.null){PRExclusion *area=[PRExclusion new];area.rect=CGRectMake(90,[y doubleValue],210,32);screen.exclusion=area;}
        NSString *actual=Select(@"STUIStatusBarVisualProvider_Phone",screen);
        NSString *expected=y==NSNull.null?@"STUIStatusBarVisualProvider_LegacyPhone":([y doubleValue]>0?@"STUIStatusBarVisualProvider_DynamicSplitMedium":@"STUIStatusBarVisualProvider_Split1170");
        NSCAssert([actual isEqual:expected],@"phone family mismatch");
        [phoneTests addObject:@{@"exclusionY":y,@"actual":actual,@"expected":expected}];
    }
    out[@"phoneFamilyTests"]=phoneTests;
    NSMutableArray *dynamic=[NSMutableArray array];
    PRScreen *fake=[PRScreen new];fake.scaleValue=3;fake.nativeScaleValue=3;
    for(NSNumber *w in @[@390,@392.999,@393,@393.001,@430])for(NSNumber *scale in @[@2.0,@3.0,@3.3]){
        fake.referenceBounds=CGRectMake(0,0,w.doubleValue,852);fake.scaleValue=scale.doubleValue;
        NSString *actual=Select(@"STUIStatusBarVisualProvider_DynamicSplit",fake),*expected=PRDynamicProvider(w.doubleValue,3,scale.doubleValue);
        NSCAssert([actual isEqual:expected],@"dynamic threshold mismatch");
        [dynamic addObject:@{@"referenceWidth":w,@"nativeScale":@3,@"screenScale":scale,@"effectiveWidth":@(w.doubleValue*3/scale.doubleValue),@"actual":actual,@"expected":expected}];
    }
    out[@"dynamicBoundaryTests"]=dynamic;
    NSMutableArray *mapping=[NSMutableArray array];PRStatus *status=[PRStatus new];status.screen=fake;PRScaleInput *input=[PRScaleInput new];input.statusBar=status;
    Class split=NSClassFromString(@"STUIStatusBarVisualProvider_Split");
    for(NSString *method in @[@"normalIconSize",@"expandedIconSize"]){
        SEL selector=NSSelectorFromString(method);IMP imp=class_getMethodImplementation(split,selector);
        for(NSNumber *scale in @[@2.0,@2.5,@2.500001,@3.0])for(NSNumber *v in @[@1.0,@1.06,@1.07,@1.08,@1.12,@1.16,@1.2412,@1.26,@1.2992000000000001,@1.1200001]){
            fake.scaleValue=scale.doubleValue;input.scaleValue=v.doubleValue;
            NSInteger actual=((NSInteger(*)(id,SEL))imp)(input,selector),expected=PRIconSize(v.doubleValue,scale.doubleValue);
            NSCAssert(actual==expected,@"iconSize mapping mismatch");
            [mapping addObject:@{@"method":method,@"screenScale":scale,@"iconScale":v,@"actual":@(actual),@"expected":@(expected)}];
        }
    }
    out[@"iconSizeTests"]=mapping;
    NSData *data=[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil];
    [data writeToFile:[dir stringByAppendingPathComponent:@"probe.json"] atomically:YES];
    [[NSJSONSerialization dataWithJSONObject:addresses options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[dir stringByAppendingPathComponent:@"class-addresses.json"] atomically:YES];
    printf("%s: %s; %lu notch tests, %lu phone-family tests, %lu boundary tests, %lu iconSize tests passed\n",[out[@"model"] UTF8String],[out[@"selectedProvider"] UTF8String],(unsigned long)notchTests.count,(unsigned long)phoneTests.count,(unsigned long)dynamic.count,(unsigned long)mapping.count);
}}
