// 原型：在模拟器内直接发布 status-bar-overrides 域
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>

int main(int argc, char **argv) {
    @autoreleasepool {
        dlopen("/System/Library/PrivateFrameworks/SystemStatus.framework/SystemStatus", RTLD_NOW);
        id pub = [[objc_getClass("STStatusBarOverridesStatusDomainPublisher") alloc] init];
        printf("publisher=%s\n", [[pub description] UTF8String]);
        Class entryClass = objc_getClass("STStatusBarDataBatteryEntry");
        typedef id (*Make)(id, SEL, long, long, BOOL, BOOL, id);
        // state 由参数指定，用于校准枚举
        id entry = ((Make)objc_msgSend)(entryClass,
            NSSelectorFromString(@"entryWithCapacity:state:saverMode:prominentlyShowsDetailString:detailString:"),
            atoi(argv[1]), atoi(argv[2]), atoi(argv[3]) != 0, NO, nil);
        printf("entry=%s\n", [[entry description] UTF8String]);
        dispatch_semaphore_t done = dispatch_semaphore_create(0);
        void (^block)(id) = ^(id data) {
            printf("data=%s\n", class_getName([data class]));
            ((void (*)(id, SEL, id, id))objc_msgSend)(data, NSSelectorFromString(@"setEntry:forKey:"), entry, @"mainBatteryEntry");
        };
        void (^completion)(id) = ^(id result) { printf("completion: %s\n", [[result description] UTF8String]); dispatch_semaphore_signal(done); };
        ((void (*)(id, SEL, id, id))objc_msgSend)(pub, NSSelectorFromString(@"updateDataWithBlock:completion:"), block, completion);
        long timedOut = dispatch_semaphore_wait(done, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
        printf("timedOut=%ld data=%s\n", timedOut, [[[pub valueForKey:@"data"] description] UTF8String]);
        [NSThread sleepForTimeInterval:atoi(argv[4])];
    }
    return 0;
}
