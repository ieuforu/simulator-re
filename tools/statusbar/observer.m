// Experimental-device observer. Reads all status-bar items, not just the three
// right-hand icons. UI actions are explicit command requests, never automatic.
#import "../signals/SignalDump.h"
static NSString *directory;
static NSMutableArray *modeEvents;
static __weak id observedControlCenter;
static id Get(id o,NSString *k);
static id ControlCenter(void){
    Class cc=NSClassFromString(@"SBControlCenterController");
    if([cc respondsToSelector:sel_getUid("sharedInstance")])return ((id(*)(id,SEL))objc_msgSend)(cc,sel_getUid("sharedInstance"));
    if(observedControlCenter)return observedControlCenter;
    for(UIScene *scene in UIApplication.sharedApplication.connectedScenes){id c=Get(scene,@"controlCenterController");if([c isKindOfClass:cc])return c;}
    return nil;
}
static id Get(id o,NSString *k){@try{return [o valueForKey:k];}@catch(id e){return nil;}}
static id Val(id o,NSString *k){id v=Get(o,k);return [v isKindOfClass:NSNumber.class]||[v isKindOfClass:NSString.class]?v:(id)NSNull.null;}
static NSDictionary *Font(UIFont *f){return f?@{@"name":f.fontName,@"size":@(f.pointSize)}:@{};}
static NSDictionary *AuditStyle(id a){return @{@"font":Font(Get(a,@"font")),@"iconSize":Val(a,@"iconSize"),@"iconScale":Val(a,@"iconScale"),@"rounded":Val(a,@"isRounded"),@"mode":Val(a,@"mode")};}
static NSDictionary *Geometry(UIView *v){
    BOOL hidden=NO;CGFloat alpha=1;NSMutableArray *chain=[NSMutableArray array];
    for(UIView *p=v;p;p=p.superview){hidden|=p.hidden;alpha*=p.alpha;[chain addObject:NSStringFromClass(p.class)];}
    return @{@"class":NSStringFromClass(v.class),@"frame":SRRect(v.frame),@"bounds":SRRect(v.bounds),
        @"screenFrame":SRRect([v convertRect:v.bounds toCoordinateSpace:v.window.screen.coordinateSpace]),
        @"hiddenInHierarchy":@(hidden),@"alphaInHierarchy":@(alpha),@"ancestry":chain};
}
static NSDictionary *Battery(UIView *v){
    NSMutableDictionary *out=[NSMutableDictionary dictionary];
    for(NSString *k in @[@"iconSize",@"rounded",@"internalSizeCategory",@"showsPercentage",@"showsInlineChargingIndicator",@"chargePercent",@"chargingState",@"saverModeActive",@"_useImagesWithCutoutsForBolt"])
        out[k]=Val(v,k);
    for(NSString *s in @[@"_lineWidthAndInterspaceForTraitCollection:",@"_outsideCornerRadiusForTraitCollection:",@"_insideCornerRadiusForTraitCollection:"])
        if([v respondsToSelector:NSSelectorFromString(s)])out[s]=@(((CGFloat(*)(id,SEL,id))objc_msgSend)(v,NSSelectorFromString(s),v.traitCollection));
    SEL fill=sel_getUid("_fillLayerFrame:cornerRadius:");
    if([v respondsToSelector:fill]){CGRect r=CGRectZero;CGFloat radius=0;((void(*)(id,SEL,CGRect*,CGFloat*))objc_msgSend)(v,fill,&r,&radius);out[@"computedFillFrame"]=SRRect(r);out[@"computedFillRadius"]=@(radius);}
    for(NSString *k in @[@"bodyLayer",@"pinLayer",@"percentFillLayer",@"boltLayer"]){CALayer *l=Get(v,k);if(l)out[k]=@{@"frame":SRRect(l.frame),@"hidden":@(l.hidden),@"opacity":@(l.opacity)};}
    out[@"percentageFont"]=Font([Get(v,@"percentageLabel") font]);return out;
}
static void Visit(UIView *v,NSMutableArray *bars,NSMutableArray *icons,NSMutableArray *texts,NSString *tag,BOOL inside){
    NSString *cls=NSStringFromClass(v.class);BOOL isBar=[cls isEqual:@"STUIStatusBar"];
    if(isBar){
        inside=YES;id provider=Get(v,@"visualProvider");
        NSMutableDictionary *b=[Geometry(v)mutableCopy];b[@"mode"]=Val(v,@"mode");b[@"orientation"]=Val(v,@"orientation");b[@"provider"]=NSStringFromClass([provider class])?:@"nil";b[@"baseStyle"]=AuditStyle(Get(v,@"styleAttributes"));
        NSMutableDictionary *values=[NSMutableDictionary dictionary];
        for(NSString *k in @[@"normalIconScale",@"expandedIconScale",@"normalIconSize",@"expandedIconSize",@"itemSpacing",@"expandedItemSpacing",@"expanded"])
            values[k]=Val(provider,k);
        b[@"providerValues"]=values;NSMutableArray *items=[NSMutableArray array];
        NSDictionary *states=Get(v,@"displayItemStates");
        for(id state in states.allValues){id item=Get(state,@"displayItem"),view=Get(item,@"view"),region=Get(Get(state,@"currentPlacementState"),@"region");
            NSMutableDictionary *r=[@{@"identifier":Val(Get(state,@"identifier"),@"string"),@"class":view?NSStringFromClass([view class]):@"nil",@"combinedOverride":AuditStyle(Get(state,@"overriddenStyleAttributes")),@"regionOverride":AuditStyle(Get(region,@"overriddenStyleAttributes"))}mutableCopy];
            if([view isKindOfClass:UIView.class])r[@"geometry"]=Geometry(view);[items addObject:r];
        }b[@"items"]=items;[bars addObject:b];
    }
    BOOL battery=[v isKindOfClass:NSClassFromString(@"_UIBatteryView")];
    if(battery||[v isKindOfClass:NSClassFromString(@"STUIStatusBarSignalView")]){
        NSMutableDictionary *r=[SRView(v,directory,[NSString stringWithFormat:@"%@-%lu",tag,(unsigned long)icons.count])mutableCopy];
        [r addEntriesFromDictionary:Geometry(v)];if(battery)r[@"battery"]=Battery(v);[icons addObject:r];
    }
    if(inside&&[v isKindOfClass:UILabel.class]){UILabel *l=(id)v;NSMutableDictionary *r=[Geometry(v)mutableCopy];r[@"text"]=l.text?:@"";r[@"font"]=Font(l.font);[texts addObject:r];}
    for(UIView *child in v.subviews)Visit(child,bars,icons,texts,tag,inside);
}
static NSDictionary *Methods(void){
    NSMutableDictionary *out=[NSMutableDictionary dictionary];unsigned n=0;Class *classes=objc_copyClassList(&n);
    for(unsigned i=0;i<n;i++){NSString *name=NSStringFromClass(classes[i]);
        if(![name containsString:@"ControlCenterController"]&&![name isEqual:@"STUIStatusBarVisualProvider_Split"]&&![name isEqual:@"STUIStatusBarVisualProvider_DynamicSplit"]&&![name isEqual:@"STUIStatusBar"]&&![name isEqual:@"SBControlCenterWindow"])continue;
        NSMutableArray *list=[NSMutableArray array];for(int meta=0;meta<2;meta++){unsigned count=0;Method *ms=class_copyMethodList(meta?object_getClass(classes[i]):classes[i],&count);
            for(unsigned j=0;j<count;j++)[list addObject:@{@"name":@(sel_getName(method_getName(ms[j]))),@"type":@(method_getTypeEncoding(ms[j])),@"classMethod":@(meta)}];free(ms);}
        out[name]=list;
    }free(classes);return out;
}
static void Snapshot(NSString *tag){
    NSArray *windows=((id(*)(id,SEL,BOOL,BOOL))objc_msgSend)(UIWindow.class,sel_getUid("allWindowsIncludingInternalWindows:onlyVisibleWindows:"),YES,NO);
    NSMutableArray *bars=[NSMutableArray array],*icons=[NSMutableArray array],*texts=[NSMutableArray array];
    for(UIWindow *w in windows)Visit(w,bars,icons,texts,tag,NO);
    id controller=ControlCenter();
    NSDictionary *out=@{@"systemVersion":UIDevice.currentDevice.systemVersion,@"model":@(getenv("SIMULATOR_MODEL_IDENTIFIER")?:"unknown"),@"screen":SRRect(UIScreen.mainScreen.bounds),@"scale":@(UIScreen.mainScreen.scale),@"controlCenterPresented":Val(controller,@"isPresented"),@"bars":bars,@"icons":icons,@"texts":texts,@"modeEvents":modeEvents?:@[]};
    [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[directory stringByAppendingFormat:@"/%@.json",tag]atomically:YES];
}
__attribute__((constructor))static void Start(void){
    if(!getenv("STATUSBAR_AUDIT_DIR"))return;directory=@(getenv("STATUSBAR_AUDIT_DIR"));
    modeEvents=[NSMutableArray array];Class bar=NSClassFromString(@"STUIStatusBar");SEL modeSelector=sel_getUid("setMode:");Method method=class_getInstanceMethod(bar,modeSelector);
    if(method){IMP original=method_getImplementation(method);IMP wrapper=imp_implementationWithBlock(^(id view,NSInteger mode){
        ((void(*)(id,SEL,NSInteger))original)(view,modeSelector,mode);
        if(modeEvents.count<80)[modeEvents addObject:@{@"mode":@(mode),@"stack":NSThread.callStackSymbols}];
    });class_replaceMethod(bar,modeSelector,wrapper,method_getTypeEncoding(method));}
    // iOS 27 has scene-scoped controllers instead of +sharedInstance. Observe
    // the existing controller during its normal setup; do not construct one.
    Class ccClass=NSClassFromString(@"SBControlCenterController");SEL visibility=sel_getUid("_updateWindowVisibility");Method vm=class_getInstanceMethod(ccClass,visibility);
    if(vm){IMP original=method_getImplementation(vm);IMP wrapper=imp_implementationWithBlock(^(id controller){observedControlCenter=controller;((void(*)(id,SEL))original)(controller,visibility);});class_replaceMethod(ccClass,visibility,wrapper,method_getTypeEncoding(vm));}
    static dispatch_source_t timer;timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(timer,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC),NSEC_PER_SEC/2,NSEC_PER_SEC/10);
    dispatch_source_set_event_handler(timer,^{
        NSString *p=[directory stringByAppendingPathComponent:@"trigger"];NSString *tag=[NSString stringWithContentsOfFile:p encoding:NSUTF8StringEncoding error:nil];if(!tag)return;
        [[NSFileManager defaultManager]removeItemAtPath:p error:nil];tag=[tag stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];if(!tag.length||![tag.lastPathComponent isEqual:tag])return;
        if([tag isEqual:@"methods"]){[[NSJSONSerialization dataWithJSONObject:Methods() options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[directory stringByAppendingPathComponent:@"methods.json"]atomically:YES];return;}
        if([tag isEqual:@"cc-open"]||[tag isEqual:@"cc-close"]){
            SEL action=sel_getUid([tag isEqual:@"cc-open"]?"presentAnimated:":"dismissAnimated:");id controller=ControlCenter();
            if([controller respondsToSelector:action])((void(*)(id,SEL,BOOL))objc_msgSend)(controller,action,YES);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC),dispatch_get_main_queue(),^{Snapshot(tag);});return;
        }
        Snapshot(tag);
    });dispatch_resume(timer);
}
