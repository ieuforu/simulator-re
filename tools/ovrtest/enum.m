#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
static NSString *field(id o, NSString *key) {
    NSString *d = [o description];
    NSRange r = [d rangeOfString:[key stringByAppendingString:@": "]];
    if (r.location == NSNotFound) return @"?";
    NSString *t = [d substringFromIndex:NSMaxRange(r)];
    return [[t componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";>"]] firstObject];
}
int main(void) { @autoreleasepool {
    dlopen("/System/Library/PrivateFrameworks/SystemStatus.framework/SystemStatus", RTLD_NOW);
    id (*bat)(id, SEL, long, long, BOOL, BOOL, id) = (void *)objc_msgSend;
    for (long i = 0; i <= 5; i++) printf("battery state %ld = %s\n", i, field(bat(objc_getClass("STStatusBarDataBatteryEntry"), NSSelectorFromString(@"entryWithCapacity:state:saverMode:prominentlyShowsDetailString:detailString:"), 50, i, NO, NO, nil), @"state").UTF8String);
    id (*wifi)(id, SEL, long, long, BOOL, long, long, BOOL) = (void *)objc_msgSend;
    SEL ws = NSSelectorFromString(@"entryWithType:status:lowDataMode:rawValue:displayValue:displayRawValue:");
    for (long i = 0; i <= 5; i++) printf("network status %ld = %s\n", i, field(wifi(objc_getClass("STStatusBarDataWifiEntry"), ws, 0, i, NO, 0, 1, NO), @"status").UTF8String);
    for (long i = 0; i <= 6; i++) printf("wifi type %ld = %s\n", i, field(wifi(objc_getClass("STStatusBarDataWifiEntry"), ws, i, 3, NO, 0, 1, NO), @"type").UTF8String);
} return 0; }
