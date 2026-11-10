// 发布电池覆盖并保持进程存活：batovr <capacity> <state> <saver 0/1> <showPercent 0/1> <秒>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
int main(int argc, char **argv) { @autoreleasepool {
    dlopen("/System/Library/PrivateFrameworks/SystemStatus.framework/SystemStatus", RTLD_NOW);
    id pub = [[objc_getClass("STStatusBarOverridesStatusDomainPublisher") alloc] init];
    typedef id (*Make)(id, SEL, long, long, BOOL, BOOL, id);
    id entry = ((Make)objc_msgSend)(objc_getClass("STStatusBarDataBatteryEntry"),
        NSSelectorFromString(@"entryWithCapacity:state:saverMode:prominentlyShowsDetailString:detailString:"),
        atol(argv[1]), atol(argv[2]), atoi(argv[3]) != 0, atoi(argv[4]) != 0, [NSString stringWithFormat:@"%s%%", argv[1]]);
    id timeEntry = ((id (*)(id, SEL, id))objc_msgSend)(objc_getClass("STStatusBarDataStringEntry"), NSSelectorFromString(@"entryWithStringValue:"), @"9:41");
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    ((void (*)(id, SEL, id, id))objc_msgSend)(pub, NSSelectorFromString(@"updateDataWithBlock:completion:"), ^(id data) {
        ((void (*)(id, SEL, id, id))objc_msgSend)(data, NSSelectorFromString(@"setEntry:forKey:"), entry, @"mainBatteryEntry");
        ((void (*)(id, SEL, id, id))objc_msgSend)(data, NSSelectorFromString(@"setEntry:forKey:"), timeEntry, @"timeEntry");
    }, ^(id r) { dispatch_semaphore_signal(done); });
    dispatch_semaphore_wait(done, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
    printf("ok %s\n", [[entry description] UTF8String]); fflush(stdout);
    [NSThread sleepForTimeInterval:atof(argv[5])];
} return 0; }
