// 仅用于实验模拟器：在 SpringBoard 读取状态栏视图/图层，触发后导出 JSON 与贴图。
// SRSIGNAL_DIR 指定目录；trigger 文件内容为输出标签。
#import "SignalDump.h"
static NSString *directory;
static NSMutableArray *styleEvents;
static IMP originalSignalStyle, originalBatteryStyle, originalStaticBatteryStyle;
static void recordStyle(id v, id a) {
    if(styleEvents.count>=100)return;
    id font=nil;@try{font=[a valueForKey:@"font"];}@catch(id e){}
    [styleEvents addObject:@{@"view":NSStringFromClass([v class]),@"styleRounded":SRValue(a,@"isRounded"),
        @"viewRounded":SRValue(v,@"rounded"),@"iconSize":SRValue(a,@"iconSize"),
        @"font":font?[font fontName]:@"unknown"}];
}
static void signalStyle(id v,SEL s,id a){((void(*)(id,SEL,id))originalSignalStyle)(v,s,a);recordStyle(v,a);}
static void batteryStyle(id v,SEL s,id a){((void(*)(id,SEL,id))originalBatteryStyle)(v,s,a);recordStyle(v,a);}
static void staticBatteryStyle(id v,SEL s,id a){((void(*)(id,SEL,id))originalStaticBatteryStyle)(v,s,a);recordStyle(v,a);}
static void visit(UIView *v, NSMutableArray *icons, NSMutableArray *layout, NSString *tag) {
    NSString *name=NSStringFromClass(v.class);
    if([name hasPrefix:@"STUIStatusBar"] && v.window) {
        NSMutableDictionary *row=[@{@"class":name,@"screenFrame":SRRect([v convertRect:v.bounds toCoordinateSpace:v.window.screen.coordinateSpace]),@"hidden":@(v.hidden),@"alpha":@(v.alpha)} mutableCopy];
        if([name isEqual:@"STUIStatusBar"]) {
            row[@"visualProvider"]=SRValue(v,@"visualProvider");
            row[@"styleAttributes"]=SRValue(v,@"styleAttributes");
        }
        [layout addObject:row];
    }
    if([v isKindOfClass:NSClassFromString(@"STUIStatusBarSignalView")] || [v isKindOfClass:NSClassFromString(@"_UIBatteryView")])
        [icons addObject:SRView(v,directory,[NSString stringWithFormat:@"%@-%lu",tag,(unsigned long)icons.count])];
    for(UIView *s in v.subviews)visit(s,icons,layout,tag);
}
static void dump(NSString *tag) {
    NSArray *windows=((id(*)(id,SEL,BOOL,BOOL))objc_msgSend)(UIWindow.class,sel_getUid("allWindowsIncludingInternalWindows:onlyVisibleWindows:"),YES,NO);
    NSMutableArray *icons=[NSMutableArray array],*layout=[NSMutableArray array];
    for(UIWindow *w in windows)visit(w,icons,layout,tag);
    NSDictionary *out=@{@"systemVersion":UIDevice.currentDevice.systemVersion,@"model":@(getenv("SIMULATOR_MODEL_IDENTIFIER")?:"unknown"),
        @"screenSize":SRSize(UIScreen.mainScreen.bounds.size),@"scale":@(UIScreen.mainScreen.scale),@"icons":icons,@"layout":layout,@"styleEvents":styleEvents};
    [[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]
        writeToFile:[directory stringByAppendingFormat:@"/%@.json",tag] atomically:YES];
}
__attribute__((constructor)) static void start(void) {
    if(!getenv("SRSIGNAL_DIR"))return;directory=@(getenv("SRSIGNAL_DIR"));
    // 包装原实现，调用参数和结果保持原样；记录各图标实际收到的样式，避免从全局样式推测。
    styleEvents=[NSMutableArray array];SEL sel=sel_getUid("applyStyleAttributes:");
    Method m=class_getInstanceMethod(NSClassFromString(@"STUIStatusBarSignalView"),sel);
    if(m)originalSignalStyle=method_setImplementation(m,(IMP)signalStyle);
    m=class_getInstanceMethod(NSClassFromString(@"STUIStatusBarBatteryView"),sel);
    if(m)originalBatteryStyle=method_setImplementation(m,(IMP)batteryStyle);
    m=class_getInstanceMethod(NSClassFromString(@"STUIStatusBarStaticBatteryView"),sel);
    if(m)originalStaticBatteryStyle=method_setImplementation(m,(IMP)staticBatteryStyle);
    static dispatch_source_t timer;
    timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(timer,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC),NSEC_PER_SEC/2,NSEC_PER_SEC/10);
    dispatch_source_set_event_handler(timer,^{
        NSString *trigger=[directory stringByAppendingPathComponent:@"trigger"];
        NSString *tag=[NSString stringWithContentsOfFile:trigger encoding:NSUTF8StringEncoding error:nil];
        if(!tag)return;tag=[tag stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if(!tag.length || ![tag.lastPathComponent isEqual:tag])return;
        dump(tag);[[NSFileManager defaultManager] removeItemAtPath:trigger error:nil];
    });dispatch_resume(timer);
}
