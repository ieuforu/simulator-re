// Experimental SpringBoard observer. Style wrappers call the original unchanged.
// PRPROVIDER_DIR/trigger requests an address-free JSON snapshot, not a UI mutation.
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
static NSString *directory;static char appliedKey;
static id Get(id x,NSString *k){@try{return [x valueForKey:k];}@catch(id e){return nil;}}
static id Value(id x,NSString *k){id v=Get(x,k);return [v isKindOfClass:NSNumber.class]||[v isKindOfClass:NSString.class]?v:(id)NSNull.null;}
static NSDictionary *Font(UIFont *f){return f?@{@"name":f.fontName,@"size":@(f.pointSize)}:@{};}
static NSDictionary *Attrs(id a){if(!a)return @{};return @{@"font":Font(Get(a,@"font")),@"emphasizedFont":Font(Get(a,@"emphasizedFont")),@"iconSize":Value(a,@"iconSize"),@"iconScale":Value(a,@"iconScale"),@"rounded":Value(a,@"isRounded"),@"mode":Value(a,@"mode")};}
static NSString *Identifier(id i){NSString *s=Get(i,@"string");return [s isKindOfClass:NSString.class]?s:NSStringFromClass([i class]);}
static void Hook(NSString *cls){
    Class c=NSClassFromString(cls);SEL s=sel_getUid("applyStyleAttributes:");Method m=class_getInstanceMethod(c,s);if(!m)return;
    IMP original=method_getImplementation(m);
    IMP replacement=imp_implementationWithBlock(^(id view,id attrs){
        ((void(*)(id,SEL,id))original)(view,s,attrs);
        objc_setAssociatedObject(view,&appliedKey,Attrs(attrs),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
    class_replaceMethod(c,s,replacement,method_getTypeEncoding(m));
}
static void Visit(UIView *v,NSMutableArray *bars){
    if([NSStringFromClass(v.class)isEqual:@"STUIStatusBar"]){
        id p=Get(v,@"visualProvider"),base=Get(v,@"styleAttributes");
        NSMutableDictionary *row=[@{@"provider":NSStringFromClass([p class]),@"mode":Value(v,@"mode"),@"orientation":Value(v,@"orientation"),
            @"baseStyle":Attrs(base),@"providerValues":[NSMutableDictionary dictionary],@"items":[NSMutableArray array]}mutableCopy];
        for(NSString *key in @[@"normalIconScale",@"expandedIconScale",@"normalIconSize",@"expandedIconSize",@"itemSpacing"])row[@"providerValues"][key]=Value(p,key);
        for(NSString *key in @[@"normalFont",@"emphasizedFont",@"normalRoundFont"])row[@"providerValues"][key]=Font(Get(p,key));
        NSDictionary *states=Get(v,@"displayItemStates");
        for(id state in states.allValues){
            id item=Get(state,@"displayItem"),view=Get(item,@"view");NSString *cls=NSStringFromClass([view class]);
            if(![cls containsString:@"SignalView"]&&![cls containsString:@"BatteryView"])continue;
            id identifier=Get(state,@"identifier"),region=Get(Get(state,@"currentPlacementState"),@"region");
            id override=((id(*)(id,SEL,id))objc_msgSend)(p,sel_getUid("overriddenStyleAttributesForDisplayItemWithIdentifier:"),identifier);
            id merged=((id(*)(id,SEL,id))objc_msgSend)(base,sel_getUid("styleAttributesWithOverrides:"),Get(state,@"overriddenStyleAttributes"));
            [row[@"items"]addObject:@{@"identifier":Identifier(identifier),@"view":cls,@"hidden":Value(view,@"hidden"),@"viewIconSize":Value(view,@"iconSize"),@"viewRounded":Value(view,@"rounded"),
                @"regionOverride":Attrs(Get(region,@"overriddenStyleAttributes")),@"displayItemOverride":Attrs(Get(item,@"overriddenStyleAttributes")),
                @"providerOverride":Attrs(override),@"cachedCombinedOverride":Attrs(Get(state,@"overriddenStyleAttributes")),
                @"mergedStyle":Attrs(merged),@"lastAppliedStyle":objc_getAssociatedObject(view,&appliedKey)?:@{}}];
        }
        [bars addObject:row];
    }
    for(UIView *child in v.subviews)Visit(child,bars);
}
__attribute__((constructor))static void Start(void){
    if(!getenv("PRPROVIDER_DIR"))return;directory=@(getenv("PRPROVIDER_DIR"));
    Hook(@"STUIStatusBarSignalView");Hook(@"STUIStatusBarBatteryView");Hook(@"STUIStatusBarStaticBatteryView");
    static dispatch_source_t timer;timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(timer,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC),NSEC_PER_SEC/2,NSEC_PER_SEC/10);
    dispatch_source_set_event_handler(timer,^{
        NSString *path=[directory stringByAppendingPathComponent:@"trigger"],*tag=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];if(!tag)return;
        tag=[tag stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!tag.length||![tag.lastPathComponent isEqual:tag])return;
        NSArray *windows=((id(*)(id,SEL,BOOL,BOOL))objc_msgSend)(UIWindow.class,sel_getUid("allWindowsIncludingInternalWindows:onlyVisibleWindows:"),YES,NO);
        NSMutableArray *bars=[NSMutableArray array];for(UIView *w in windows)Visit(w,bars);
        NSDictionary *out=@{@"model":@(getenv("SIMULATOR_MODEL_IDENTIFIER")?:"unknown"),@"systemVersion":UIDevice.currentDevice.systemVersion,@"statusBars":bars};
        [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[directory stringByAppendingFormat:@"/%@.json",tag]atomically:YES];
        [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    });dispatch_resume(timer);
}
