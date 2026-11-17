// 导出档位参数、独立实例的图层和原始图像，保留进程供 lldb 读取方法。
// signalprobe <output-directory> [--wait]
#import "SignalDump.h"
#import "SignalGeometry.h"
#import <dlfcn.h>
#import <unistd.h>
static double scalar(Class c,const char *sel,long size) {return ((double(*)(id,SEL,long))objc_msgSend)(c,sel_getUid(sel),size);}
int main(int argc,char **argv) {@autoreleasepool {
    if(argc<2 || argc>3 || (argc==3 && strcmp(argv[2],"--wait")))return 2;
    dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    NSString *dir=@(argv[1]);NSError *err=nil;
    if(![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&err]){fprintf(stderr,"%s\n",err.description.UTF8String);return 1;}
    NSMutableArray *rows=[NSMutableArray array];
    NSMutableString *ivars=[NSMutableString string],*methods=[NSMutableString string];
    for(NSString *name in @[@"STUIStatusBarSignalView",@"STUIStatusBarCellularSignalView",@"STUIStatusBarWifiSignalView",@"STUIStatusBarStyleAttributes"]){
        Class c=NSClassFromString(name);unsigned n=0;Ivar *vs=class_copyIvarList(c,&n);
        for(unsigned i=0;i<n;i++)[ivars appendFormat:@"%td %s\n",ivar_getOffset(vs[i]),ivar_getName(vs[i])];free(vs);
        for(int meta=0;meta<2;meta++){Method *ms=class_copyMethodList(meta?object_getClass(c):c,&n);for(unsigned i=0;i<n;i++)[methods appendFormat:@"%c[%@ %s]\n",meta?'+':'-',name,sel_getName(method_getName(ms[i]))];free(ms);}
    }
    for(NSString *kind in @[@"Cellular",@"Wifi"]) {
        Class c=NSClassFromString([NSString stringWithFormat:@"STUIStatusBar%@SignalView",kind]);
        BOOL cell=[kind isEqual:@"Cellular"];long count=cell?4:3;
        for(long size=1;size<=17;size++) {
            NSMutableDictionary *row=[@{@"kind":kind,@"iconSize":@(size),@"interspace":@(scalar(c,"_interspaceForIconSize:",size))} mutableCopy];
            CGSize sz=((CGSize(*)(id,SEL,long,long))objc_msgSend)(c,sel_getUid("_intrinsicContentSizeForNumberOfBars:iconSize:"),count,size);
            row[@"intrinsicSize"]=SRSize(sz);NSMutableArray *values=[NSMutableArray array];
            if(cell){row[@"barWidth"]=@(scalar(c,"_barWidthForIconSize:",size));row[@"barCornerRadius"]=@(scalar(c,"_barCornerRadiusForIconSize:",size));}
            else row[@"totalWidth"]=@(scalar(c,"_totalWidthForIconSize:",size));
            for(long i=0;i<count;i++)[values addObject:@(((double(*)(id,SEL,long,long))objc_msgSend)(c,sel_getUid(cell?"_heightForNormalBarAtIndex:iconSize:":"_barThicknessAtIndex:iconSize:"),i,size))];
            row[cell?@"heights":@"thicknesses"]=values;
            [rows addObject:row];
            if(size!=4 && size!=7 && size!=8)continue;
            for(int rounded=0;rounded<2;rounded++) {
                UIView *v=[[c alloc] initWithFrame:CGRectZero];
                [UIView performWithoutAnimation:^{
                    [v setValue:@(size) forKey:@"iconSize"];[v setValue:@(rounded) forKey:@"rounded"];
                    [v setValue:@(count) forKey:@"numberOfBars"];[v setValue:@2 forKey:@"signalMode"];
                    [v setValue:@(count) forKey:@"numberOfActiveBars"];
                    [v setValue:UIColor.blackColor forKey:@"activeColor"];[v setValue:[UIColor.blackColor colorWithAlphaComponent:0.2] forKey:@"inactiveColor"];
                    ((void(*)(id,SEL))objc_msgSend)(v,sel_getUid("_iconSizeDidChange"));
                    v.frame=(CGRect){CGPointZero,v.intrinsicContentSize};[v setNeedsLayout];[v layoutIfNeeded];
                }];
                NSString *tag=[NSString stringWithFormat:@"%@-%ld-rounded%d",kind,size,rounded];
                NSDictionary *view=SRView(v,dir,tag);
                if(cell) {
                    [UIImagePNGRepresentation(SRRenderLayer(v.layer,3))writeToFile:[dir stringByAppendingFormat:@"/%@-active4.png",tag] atomically:YES];
                    for(int active=0;active<4;active++) {
                        [UIView performWithoutAnimation:^{[v setValue:@(active) forKey:@"numberOfActiveBars"];[v layoutIfNeeded];}];
                        [UIImagePNGRepresentation(SRRenderLayer(v.layer,3))writeToFile:[dir stringByAppendingFormat:@"/%@-active%d.png",tag,active] atomically:YES];
                    }
                }
                [[NSJSONSerialization dataWithJSONObject:view options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil] writeToFile:[dir stringByAppendingFormat:@"/%@.json",tag] atomically:YES];
            }
        }
    }
    NSDictionary *out=@{@"systemVersion":UIDevice.currentDevice.systemVersion,@"scale":@(UIScreen.mainScreen.scale),@"parameters":rows};
    NSData *data=[NSJSONSerialization dataWithJSONObject:out options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:&err];
    if(!data || ![data writeToFile:[dir stringByAppendingPathComponent:@"parameters.json"] options:NSDataWritingAtomic error:&err])return 1;
    [ivars writeToFile:[dir stringByAppendingPathComponent:@"ivars.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [methods writeToFile:[dir stringByAppendingPathComponent:@"methods.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    printf("iOS %s scale=%.0f pid=%d; exported 34 parameter rows and 12 view fixtures\n",UIDevice.currentDevice.systemVersion.UTF8String,UIScreen.mainScreen.scale,getpid());fflush(stdout);
    if(argc==3)while(1)pause();return 0;
}}
