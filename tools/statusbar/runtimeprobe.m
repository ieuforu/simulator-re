// Local runtime inventory for a version-matched disassembly session.
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
#import <unistd.h>
int main(int argc,char **argv){@autoreleasepool{
    if(argc<2||argc>3)return 2;
    dlopen("/System/Library/PrivateFrameworks/SystemStatusUI.framework/SystemStatusUI",RTLD_NOW);
    // Older ControlCenterUI loads SpringBoardUI, which asserts outside SpringBoard.
    if(UIDevice.currentDevice.systemVersion.doubleValue>=27)
        dlopen("/System/Library/PrivateFrameworks/ControlCenterUI.framework/ControlCenterUI",RTLD_NOW);
    NSString *dir=@(argv[1]);[[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    NSMutableDictionary *all=[NSMutableDictionary dictionary],*addresses=[NSMutableDictionary dictionary],*implementations=[NSMutableDictionary dictionary];unsigned n=0;Class *classes=objc_copyClassList(&n);
    for(unsigned i=0;i<n;i++){Class c=classes[i];NSString *name=NSStringFromClass(c);
        if(![name hasPrefix:@"STUIStatusBar"]&&![name isEqual:@"CCUIStatusBar"]&&![name isEqual:@"_UIBatteryView"]&&![name isEqual:@"_UIStaticBatteryView"])continue;
        addresses[[NSString stringWithFormat:@"0x%llx",(unsigned long long)c]]=name;
        NSMutableArray *methods=[NSMutableArray array],*ivars=[NSMutableArray array];unsigned count=0;Ivar *vs=class_copyIvarList(c,&count);
        for(unsigned j=0;j<count;j++)[ivars addObject:@{@"name":@(ivar_getName(vs[j])),@"type":@(ivar_getTypeEncoding(vs[j])),@"offset":@(ivar_getOffset(vs[j]))}];free(vs);
        for(int meta=0;meta<2;meta++){Method *ms=class_copyMethodList(meta?object_getClass(c):c,&count);
            for(unsigned j=0;j<count;j++){[methods addObject:@{@"name":@(sel_getName(method_getName(ms[j]))),@"type":@(method_getTypeEncoding(ms[j])),@"classMethod":@(meta)}];
                implementations[[NSString stringWithFormat:@"%c[%@ %s]",meta?'+':'-',name,sel_getName(method_getName(ms[j]))]]=[NSString stringWithFormat:@"0x%llx",(unsigned long long)method_getImplementation(ms[j])];
            }free(ms);}
        all[name]=@{@"superclass":NSStringFromClass(class_getSuperclass(c))?:@"nil",@"methods":methods,@"ivars":ivars};
    }free(classes);
    NSDictionary *data=@{@"version":UIDevice.currentDevice.systemVersion,@"classes":all};
    [[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[dir stringByAppendingPathComponent:@"runtime.json"]atomically:YES];
    [[NSJSONSerialization dataWithJSONObject:addresses options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[dir stringByAppendingPathComponent:@"class-addresses.json"]atomically:YES];
    [[NSJSONSerialization dataWithJSONObject:implementations options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil]writeToFile:[dir stringByAppendingPathComponent:@"method-addresses.json"]atomically:YES];
    printf("iOS %s pid=%d\n",UIDevice.currentDevice.systemVersion.UTF8String,getpid());fflush(stdout);
    if(argc==3&&!strcmp(argv[2],"--wait"))while(1)pause();
}return 0;}
