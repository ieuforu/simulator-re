#import "StatusBarBridge.h"
#import <dlfcn.h>
#import <objc/runtime.h>

// 私有类没有头文件。这里按运行时查到的签名声明，由编译器生成正确的 ABI。
@protocol SBLBatteryEntry
+ (id)entryWithCapacity:(long long)capacity state:(long long)state saverMode:(BOOL)saver
    prominentlyShowsDetailString:(BOOL)prominent detailString:(nullable NSString *)detail;
@end
@protocol SBLStringEntry
+ (id)entryWithStringValue:(NSString *)value;
@end
@protocol SBLWifiEntry
+ (id)entryWithType:(long long)type status:(long long)status lowDataMode:(BOOL)low
           rawValue:(long long)raw displayValue:(long long)display displayRawValue:(BOOL)displayRaw;
@end
@protocol SBLCellularEntry
+ (id)entryWithType:(long long)type stringValue:(nullable NSString *)string
    crossfadeStringValue:(nullable NSString *)crossfade badgeStringValue:(nullable NSString *)badge
    wifiCalling:(BOOL)wifiCalling callForwarding:(BOOL)callForwarding
    showsSOSWhenDisabled:(BOOL)sos sosAvailable:(BOOL)sosAvailable isBootstrapCellular:(BOOL)bootstrap
    status:(long long)status lowDataMode:(BOOL)low
    rawValue:(long long)raw displayValue:(long long)display displayRawValue:(BOOL)displayRaw;
@end
@protocol SBLDisabledEntry
+ (id)disabledEntry;
@end
@protocol SBLMutableOverrides
- (void)setEntry:(nullable id)entry forKey:(NSString *)key;
@end
@protocol SBLPublisher
- (void)setData:(id)data;
- (id)data;
@end
@protocol SBLDomain
- (id)data;
- (void)observeDataWithBlock:(void (^)(id))block;
@end

static BOOL loadFramework(void) {
    static BOOL loaded;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        loaded = dlopen("/System/Library/PrivateFrameworks/SystemStatus.framework/SystemStatus", RTLD_NOW) != NULL;
    });
    return loaded;
}

static Class privateClass(const char *name) {
    return loadFramework() ? objc_getClass(name) : Nil;
}

@implementation StatusBarBridge {
    id<SBLPublisher> _publisher;
    id<SBLDomain> _domain;
}

- (instancetype)init {
    if ((self = [super init])) {
        _publisher = [[privateClass("STStatusBarOverridesStatusDomainPublisher") alloc] init];
        _domain = [[privateClass("STStatusBarOverridesStatusDomain") alloc] init];
        [_domain observeDataWithBlock:^(id data) {}];
    }
    return self;
}

- (BOOL)available {
    return _publisher != nil && privateClass("STMutableStatusBarOverridesStatusDomainData") != Nil;
}

+ (id)timeEntry:(NSString *)text {
    return [(id<SBLStringEntry>)privateClass("STStatusBarDataStringEntry") entryWithStringValue:text];
}

+ (id)batteryEntryWithCapacity:(NSInteger)capacity state:(NSInteger)state
                     saverMode:(BOOL)saverMode showPercent:(BOOL)showPercent {
    return [(id<SBLBatteryEntry>)privateClass("STStatusBarDataBatteryEntry")
        entryWithCapacity:capacity state:state saverMode:saverMode
        prominentlyShowsDetailString:showPercent
        detailString:[NSString stringWithFormat:@"%ld%%", (long)capacity]];
}

+ (id)wifiEntryWithType:(NSInteger)type status:(NSInteger)status bars:(NSInteger)bars {
    return [(id<SBLWifiEntry>)privateClass("STStatusBarDataWifiEntry")
        entryWithType:type status:status lowDataMode:NO rawValue:0 displayValue:bars displayRawValue:NO];
}

+ (id)cellularEntryWithType:(NSInteger)type status:(NSInteger)status
                       bars:(NSInteger)bars carrier:(NSString *)carrier {
    return [(id<SBLCellularEntry>)privateClass("STStatusBarDataCellularEntry")
        entryWithType:type stringValue:carrier crossfadeStringValue:nil badgeStringValue:nil
        wifiCalling:NO callForwarding:NO showsSOSWhenDisabled:NO sosAvailable:NO isBootstrapCellular:NO
        status:status lowDataMode:NO rawValue:0 displayValue:bars displayRawValue:NO];
}

+ (id)hiddenWifiEntry {
    return [(id<SBLDisabledEntry>)privateClass("STStatusBarDataWifiEntry") disabledEntry];
}

+ (id)hiddenCellularEntry {
    return [(id<SBLDisabledEntry>)privateClass("STStatusBarDataCellularEntry") disabledEntry];
}

- (void)publishEntries:(NSDictionary<NSString *, id> *)entries {
    if (!self.available) return;
    id<SBLMutableOverrides> data = [[privateClass("STMutableStatusBarOverridesStatusDomainData") alloc] init];
    [entries enumerateKeysAndObjectsUsingBlock:^(NSString *key, id entry, BOOL *stop) {
        [data setEntry:entry forKey:key];
    }];
    [_publisher setData:data];
}

- (NSString *)currentDomainDescription {
    return [[(NSObject *)_domain.data description] copy] ?: @"(无法读取)";
}

@end
