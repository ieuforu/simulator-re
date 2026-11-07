#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 对 SystemStatus 私有框架的薄封装。只用于模拟器内的调试。
@interface StatusBarBridge : NSObject

/// 框架和发布者是否可用。不可用时其余方法都不产生效果。
@property (nonatomic, readonly) BOOL available;

+ (nullable id)timeEntry:(NSString *)text;
+ (nullable id)batteryEntryWithCapacity:(NSInteger)capacity
                                  state:(NSInteger)state
                              saverMode:(BOOL)saverMode
                            showPercent:(BOOL)showPercent;
+ (nullable id)wifiEntryWithType:(NSInteger)type status:(NSInteger)status bars:(NSInteger)bars;
+ (nullable id)cellularEntryWithType:(NSInteger)type
                              status:(NSInteger)status
                                bars:(NSInteger)bars
                             carrier:(NSString *)carrier;
+ (nullable id)hiddenWifiEntry;
+ (nullable id)hiddenCellularEntry;

/// 用这份完整快照替换当前覆盖。key 是 STStatusBarData 的 entry 名。
- (void)publishEntries:(NSDictionary<NSString *, id> *)entries;

/// 从 status-bar-overrides 域读回当前内容，用于核对。
- (NSString *)currentDomainDescription;

@end

NS_ASSUME_NONNULL_END
