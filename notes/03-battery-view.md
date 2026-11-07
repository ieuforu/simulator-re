# 06 电池图标的代码还原

根据 iOS 27.0 模拟器的 UIKitCore 和 SystemStatusUI 反汇编手工还原，用于学习。

这不是 Apple 的原始源码：方法名、实例变量名和常量是真实的，局部变量名和注释是还原时加的，`...` 表示没读完或省略的部分。

## 还原方法

1. 用 `tools/simprobe` 在模拟器内导出类、方法和实例变量偏移。
2. 用 lldb 附加自己的 StatusBarLab。它和 SpringBoard 加载同一份 UIKitCore，不受 SIP 限制。
3. 用 `tools/lldb/annotate.py` 反汇编，并把常量、字符串和实例变量偏移解析成可读内容。
4. 手工把汇编改写成 Objective-C，再用不同的状态组合实测。

## 数据到显示的流程

```
STStatusBarDataBatteryEntry（capacity、state、saverModeActive）
  → -[STUIStatusBarBatteryItem applyUpdate:toDisplayItem:]
  → _UIBatteryView 的 setter：chargingState、chargePercent、saverModeActive
  → _updateFillColor、_updateBodyColors、_updateBolt
  → _UIStaticBatteryView 把颜色应用到 percentFillLayer
```

## 关键常量

| 常量 | 含义 |
|---|---|
| `0.2` / `0.1` | 低电量阈值：非 iPad / iPad。iPad 的值只读到常量，未实测 |
| `0.01` | 电量小于等于此值时按 0 处理 |
| `0.995` | 显示百分比时，电量达到此值就不画闪电 |
| `1.0` | 填充层的最小宽度（pt） |
| `0.25` | 百分比相关的 UIView 动画时长（秒） |
| `0.5` | 颜色变化的 CATransaction 时长（秒） |

## 状态映射

| entry state | 含义 | chargingState | 填充色 | 闪电 |
|---|---|---|---|---|
| 0 | 放电 | 0 | 默认 | 无 |
| 1 | 充电 | 1 | 绿 | 有 |
| 2 | 已充满 | 3 | 绿 | 灰 |
| 3 | 未充电 | 4 | 默认 | 灰 |
| 4 | 无法充电 | 0 | 默认 | 无 |

省电模式和低电量优先于上表的填充色，优先级是省电 > 低电量 > 充电 > 默认。
state 4 这一行由映射表推出，没有实测。

## 还原代码

```objc
@implementation STUIStatusBarBatteryItem

- (id)applyUpdate:(id)update toDisplayItem:(id)item {
    id result = [super applyUpdate:update toDisplayItem:item];
    STStatusBarDataBatteryEntry *entry = update.data.mainBatteryEntry;

    if (item.identifier == self.class.percentDisplayIdentifier) {
        // 百分比文字项，略
    }
    _UIBatteryView *view = (item.identifier == self.class.iconDisplayIdentifier)
        ? self.batteryView : self.staticBatteryView;

    if (update.dataChanged) {
        double percent = entry.capacity / 100.0;
        if (percent <= 0.01) percent = 0;          // 1% 及以下按 0 处理

        // 数据层的 state 和视图层的 chargingState 不是同一套枚举
        static const long table[5] = {
            0,  // draining           -> 0
            1,  // charging           -> 1
            3,  // charged            -> 3
            4,  // notCharging        -> 4
            0,  // chargingImpossible -> 0
        };
        if (entry.state <= 4) view.chargingState = table[entry.state];

        if (view.showsPercentage != wantsPercent) view.showsPercentage = wantsPercent;
        view.chargePercent = percent;
        view.saverModeActive = entry.saverModeActive;
    }
    // 样式部分，略
    return result;
}

@end


@implementation _UIBatteryView

- (void)_commonInit {
    [self _createBodyLayers];
    [self _createFillLayer];
    self.sizeCategory = ...;
    // 常量表 kThreshold = { 0.2, 0.1 }：非 iPad 20%，iPad 10%（iPad 值只读到常量，未实测）
    long idiom = UIDevice.currentDevice.userInterfaceIdiom;
    self.lowBatteryChargePercentThreshold = kThreshold[idiom == UIUserInterfaceIdiomPad ? 1 : 0];
    // 注册 trait 变化和通知，略
    [self _updateTransform];
}

- (BOOL)isLowBattery {
    if (_lowBatteryMode != 0) return _lowBatteryMode == 2;   // 可以强制指定
    return self.chargePercent <= self.lowBatteryChargePercentThreshold;
}

- (UIColor *)_batteryFillColor {
    if (self == nil) return nil;
    UIColor *color;
    UITraitCollection *traits;

    if (self.saverModeActive) {
        traits = [self.traitCollection traitCollectionByModifyingTraits:^(id<UIMutableTraits> t) {
            t.accessibilityContrast = ...;
        }];
        color = UIColor.systemYellowColor;
    } else if (self.isLowBattery) {
        traits = [self.traitCollection traitCollectionByModifyingTraits:^(id<UIMutableTraits> t) {
            t.accessibilityContrast = ...;
            t.userInterfaceStyle = ...;
        }];
        color = UIColor.systemRedColor;
    } else if (self.chargingState != 4 && self.chargingState != 0) {
        traits = [self.traitCollection traitCollectionByModifyingTraits:^(id<UIMutableTraits> t) {
            t.accessibilityContrast = ...;
            t.userInterfaceStyle = ...;
        }];
        color = UIColor.systemGreenColor;
    } else {
        return self.fillColor;
    }
    return [color resolvedColorWithTraitCollection:traits];
}

- (BOOL)_shouldShowBolt {
    BOOL roomForBolt = _showsPercentage ? (_chargePercent < 0.995) : YES;
    if (!_showsInlineChargingIndicator) return NO;
    return (_chargingState != 0) && roomForBolt;
}

- (BOOL)_boltIsInactive {
    return _chargingState > 2;      // charged(3)、notCharging(4) 的闪电是灰的
}

- (void)setSaverModeActive:(BOOL)active {
    if (_saverModeActive == active) return;
    _saverModeActive = active;
    [self _updateBodyColors];
    [self _updateFillColor];
}

- (void)setChargingState:(long)state {
    if (state == _chargingState) return;
    _chargingState = state;
    if (_showsPercentage) {
        [UIView animateWithDuration:0.25 animations:^{ ... }];
    }
    [self _updateBodyColors];
    [self _updateFillColor];
    [self _updateBolt];
}

- (void)setChargePercent:(double)percent {
    if (percent == _chargePercent) return;
    BOOL boltBefore = self._shouldShowBolt;
    BOOL lowBefore = self.isLowBattery;
    _chargePercent = MIN(percent, 1.0);          // 夹取逻辑按指令推断

    if (self._shouldShowBolt != boltBefore) {
        [UIView performWithoutAnimation:^{ ... }];
    }
    if (_showsPercentage && self.isLowBattery != lowBefore) {
        [UIView animateWithDuration:0.25 animations:^{ ... }];
    }
    [self __updateFillLayer];
    [self _updatePercentage];
    if (!lowChangedHandled) [self _updateBodyColors];
}

- (void)__updateFillLayer {
    if (_internalSizeCategory != 0 || self.hasValidIconSize) {
        [self _updateFillLayer];
        [self _updateFillColor];
    }
}

- (void)_updateFillColor {
    void (^apply)(void) = ^{ ... };              // 内部调用 _updateBatteryFillColor
    if ([CATransaction currentState]) {          // 已在事务里，直接执行
        apply();
        return;
    }
    [CATransaction begin];
    if (UIView.areAnimationsEnabled) [CATransaction setAnimationDuration:0.5];
    else                             [CATransaction setDisableActions:YES];
    apply();
    [CATransaction commit];
}

- (CGRect)_fillLayerFrame:(BOOL)useMinimumWidth cornerRadius:(CGFloat *)outRadius {
    UITraitCollection *traits = self.traitCollection;
    CGSize battery = [self _batterySizeForTraitCollection:traits];
    CGRect bounds = self.bounds;

    CGFloat fillWidth = battery.width * self.chargePercent;
    CGFloat radius = [self _insideCornerRadiusForTraitCollection:traits];
    if (self.rounded) radius = battery.height / self._roundedCornerRadiusFactor;

    CGFloat width = UIRoundToViewScale(fillWidth, self);
    if (useMinimumWidth) width = MAX(width, 1.0);   // 至少 1pt，低电量时不会消失
    if (outRadius) *outRadius = radius;
    return ...;                                     // 其余几何未读完
}

@end


@implementation _UIStaticBatteryView

// 只重写了颜色的应用方式：状态栏版本把颜色乘到 percentFillLayer 上
- (void)_updateBatteryFillColor {
    self.percentFillLayer.contentsMultiplyColor = self._batteryFillColor.CGColor;
    self.percentFillLayer.opacity = 1.0;
    [self _updateBodyColors];
}

@end
```

## 尚未还原

- `-[_UIBatteryView _updateBolt]`（301 条指令，闪电图层和动画）。
- `-[_UIBatteryView _updatePercentage]`。
- `_fillLayerFrame:cornerRadius:` 后半段的几何计算。
- `setChargePercent:` 的夹取逻辑是从指令推断的，把握较小。
