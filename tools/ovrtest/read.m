// 读取 status-bar-overrides 域当前内容
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
int main(void) {
    @autoreleasepool {
        dlopen("/System/Library/PrivateFrameworks/SystemStatus.framework/SystemStatus", RTLD_NOW);
        id domain = [[objc_getClass("STStatusBarOverridesStatusDomain") alloc] init];
        void (^observer)(id) = ^(id data) {};
        ((void (*)(id, SEL, id))objc_msgSend)(domain, NSSelectorFromString(@"observeDataWithBlock:"), observer);
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
        puts([[[domain valueForKey:@"data"] description] UTF8String]);
    }
    return 0;
}
