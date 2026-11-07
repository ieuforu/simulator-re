# 03 状态栏逆向（iOS 27.0 模拟器）

标记：**[实测]** 调用栈或截图直接看到；**[静态]** 只有符号或字符串证据，运行时未验证。

## 链路

```
host: simre / simctl
  │  -[SimDevice overrideStatusBarTimeString:error:] 等                    [实测]
  │  -[SimDevice _sendStatusBarOverrideDict:error:]                        [实测：反汇编]
  │  -[SimDevice _sendBridgeRequest:caller:error:]                         [实测：反汇编]
  ▼
device: /usr/libexec/CoreSimulatorBridge                                   [实测：进程存在]
  │  实际文件在 host：CoreSimulator.framework/.../Platforms/iphoneos/usr/libexec/
  │  CSBStatusBarOverrides_iOS_16_1 -applyDictionary:toData:error:         [静态]
  │  STStatusBarOverridesStatusDomainPublisher（域 status-bar-overrides）   [实测：读回域数据]
  ▼
systemstatusd                                                              [静态：转发细节未抓到]
  ▼
SpringBoard
  │  STUIStatusBarDataBroadcaster（block 回到主队列）                       [实测]
  │  -[STUIStatusBar _updateWithData:completionHandler:]                   [实测]
  │  -[STUIStatusBarDataAggregator updateWithData:]        time=15:14 真实  [实测]
  │    _updateForOverlayWithData: → _updateForDelayedKeysWithData:         [实测]
  │    → _updateForCoalescedKeysWithData:                                  [实测]
  │  -[STUIStatusBar _updateWithAggregatedData:]           time=15:14       [实测]
  │  -[STUIStatusBar _updateDisplayedItemsWithData:...]    time=06:06 覆盖  [实测]
  ▼
SBStatusBarWindow (level 1000) → STUIStatusBar_Wrapper → STUIStatusBar
  └ STUIStatusBarForegroundView → StringView / CellularSignalView /
    WifiSignalIconView / StaticBatteryView                                 [实测：视图树]
```

## 关键结论

| # | 结论 | 证据 |
|---|---|---|
| 1 | 状态栏由 SpringBoard 渲染，不在 App 进程内 | 注入“设置”后找不到视图，也没有更新调用，但屏幕上时间变了 |
| 2 | 实际类在 `SystemStatusUI`（197 个 `STUI*` 类）。UIKit 里同名的 `UIStatusBar_Modern`、`_UIStatusBar` 在 SpringBoard 这条路径上没被调用 | 探针挂在 UIKit 类上 0 次；挂在 STUI 类上触发 |
| 3 | 真实时间和覆盖时间在 `_updateWithAggregatedData:` 内部切换 | 入参 15:14，传给下一层已是 06:06 |
| 4 | 时钟的每分钟更新走 `SBFMachNextMinuteDateProvider` → `SBStatusBarStateAggregator` → `+[UIStatusBarServer postStatusBarData:withActions:]`，这是另一条路径，与覆盖无关 | 调用栈 |
| 5 | 覆盖在 SpringBoard 重启后仍然生效 | 重启后没有重新设置，仍显示 08:08 |
| 6 | 写入相同的值不会触发更新 | 第二次写 8:08 时 0 次调用 |

## 枚举（由 simctl 反向校准）

| 字段 | 值 |
|---|---|
| network | 0 hide 或 wifi，6 3g，7 4g，8 lte，9 lte-a，10 lte+，11 5g，12 5g+，13 5g-uwb，14 5g-uc |
| wifi 模式 | 1 searching，2 failed，3 active |
| 蜂窝模式 | 0 notSupported，1 searching，2 failed，3 active |
| 电池状态 | 0 discharging，1 charging，2 charged |

`simctl` 的 `hide` 和 `wifi` 都显示 0，两者如何区分没有查。

## 方法与限制

- `lldb` 附加 `CoreSimulatorBridge` 被拒绝（Apple 签名，SIP 开启）。没有关 SIP。
- `ipsw class-dump` 解析 iOS 27 的 dyld 缓存时 panic，改用 `tools/simprobe` 在模拟器内做 ObjC 运行时内省。
- SpringBoard 注入：`launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES=...`，只影响下一次启动。
- 前两版 `sbtrace` 挂了旧的 `UIStatusBarServer` 方法，导致测试设备上的 SpringBoard 两次 SIGSEGV，已移除该 hook。

## 尚未验证

1. `systemstatusd` 内部如何转发到 SpringBoard：系统进程无法附加。Bridge 写入域这一步已实测，见下文 04。
2. `_updateWithAggregatedData:` 内部具体在哪里替换时间。可以继续在 `+356` 之前看 `overlayData` 或反编译。

## 电池图标

视图：`STUIStatusBarBatteryItem` → `STUIStatusBarStaticBatteryView`（继承 `_UIStaticBatteryView`）。
数据：`STStatusBarDataBatteryEntry`，字段 `capacity`、`state`、`saverModeActive`、`prominentlyShowsDetailString`、`detailString`。

| 覆盖 | 实测外观 |
|---|---|
| discharging 100 / 50 | 白色，按电量填充 |
| discharging 15 / 5 | 红色（红色阈值未测，在 15 到 50 之间） |
| charging 42 | 绿色填充加闪电 |
| charged 100 | 绿色填满加闪电，电池头也变绿 |
| charging 80 + not-charging | 白色填充加镂空闪电 |

- `SimDevice` 只开放 state、level、showNotCharging，没有 `saverModeActive`。低电量模式要直接发布到域，见下文 04。
- 设置 not-charging 后画面生效，但 `simctl status_bar list` 不显示电池行，原因未查。

# 04 App 直接发布（StatusBarLab）

App 在模拟器内直接写 `status-bar-overrides` 域，不经过 host，也不经过 `SimDevice`。

```
SwiftUI → STMutableStatusBarOverridesStatusDomainData.setEntry:forKey:
        → STStatusBarOverridesStatusDomainPublisher.setData:
        → status-bar-overrides 域 → SpringBoard
```

| # | 发现 | 证据 | 状态 |
|---|---|---|---|
| 1 | 任何带权限的模拟器进程都能发布这个域 | 原型和 App 都生效 | 实测 |
| 2 | 权限要放在 `__TEXT,__entitlements` 段，不能写进 ad-hoc 代码签名 | 写进签名时 `simctl spawn` 报 Security policy issue（code 163） | 实测 |
| 3 | 不带权限时读取域返回 null | `ovrread-noent` | 实测 |
| 4 | Bridge 确实把覆盖写进这个域：时间写 `timeEntry` 和 `shortTimeEntry`，电池写 `mainBatteryEntry` | 用 `STStatusBarOverridesStatusDomain` 读回 | 实测，修正了上文“静态”标记的这一段 |
| 5 | 低电量模式可用：`saverMode:YES` 显示黄色电池 | UI 测试截图 | 实测 |
| 6 | 发布进程退出后覆盖仍保留（至少 10 秒） | 退出后读域 | 实测 |
| 7 | `simre clear` 能清除原型发布的覆盖 | 清除后 entries=0 | 实测 |
| 8 | `updateDataWithBlock:` 会合并现有覆盖 | simre 写时间后再发电池，三项都在 | 实测 |

App 用的是 `setData:` 完整快照，理论上会替换其他来源的覆盖，这一点没有单独测。

## 枚举（由框架 description 校准）

| 字段 | 值 |
|---|---|
| 电池 state | 0 draining，1 charging，2 charged，3 notCharging，4 chargingImpossible |
| 网络 status | 0 unavailable，1 disabled，2 disconnected，3 searching，4 warning，5 connected |
| Wi-Fi type | 0 regular，1 hotspot，2 ethernet |
| 蜂窝 type | 0 none，1 1x，2 GPRS，3 Edge，4 UMTS，5 4G，6 LTE，7 5GE，8 LTEA，9 LTEPlus，10 5G，11 5GPlus，12 5GUWB，13 5GUC，14 Satellite，15 5GA |

注意这里的数值和 `SimDevice` 的枚举不同，比如 `SimDevice` 的电池 2 是 charged，网络类型 8 是 LTE。

# 05 电池图标的实现（逆向还原）

Apple 没有公开源码。下面是根据 iOS 27.0 反汇编和实测写的**伪代码**，不是原始代码。完整版见 `notes/03-battery-view.md`。

方法：lldb 附加自己的 StatusBarLab。它和 SpringBoard 加载同一份 UIKitCore，而且不受 SIP 限制，符号都能解析。

继承：`STUIStatusBarStaticBatteryView` → `_UIStaticBatteryView` → `_UIBatteryView` → `UIView`。

```
// _UIBatteryView
batteryFillColor():
    if saverModeActive:  return systemYellow
    if isLowBattery():   return systemRed
    if chargingState != 0 and != 4: return systemGreen
    return fillColor

isLowBattery():
    if 手动指定了低电量状态 != 0: return 该状态 == 2
    return chargePercent <= lowBatteryChargePercentThreshold

// _UIStaticBatteryView 重写
updateBatteryFillColor():
    percentFillLayer.contentsMultiplyColor = batteryFillColor().CGColor
    percentFillLayer.opacity = ...
    updateBodyColors()
```

子类只重写了“把颜色应用到哪个图层”，选色仍走父类的 `_batteryFillColor`。

## 实测验证

| 条件 | 外观 |
|---|---|
| 电量 20 / 21（放电） | 红色 / 普通色，阈值确认为 ≤20% |
| 15%，充电 | 红色加闪电 |
| 15%，省电 | 黄色 |
| 15%，充电加省电 | 黄色加闪电 |
| 80%，省电 | 黄色 |
| 80%，充电加省电 | 黄色加闪电 |
| 80%，notCharging | 普通色加灰色闪电 |
| 15%，notCharging | 红色加灰色闪电 |

优先级：省电 > 低电量 > 充电 > 默认色。闪电是否显示和颜色分开判断。

## 补充（已解码）

- entry `state` 到 `chargingState` 的查找表是 `(0, 1, 3, 4, 0)`，所以 `chargingState` 的 3 是已充满，4 是未充电。
- 绿色条件是 `chargingState != 0 && != 4`，灰色闪电条件是 `chargingState > 2`。
- 容量换算：`capacity / 100`，≤0.01 时按 0 处理。
- 完整还原代码见 `notes/03-battery-view.md`，工具是 `tools/lldb/annotate.py`。

## 未解码

- 闪电路径 `+_boltBezierPathForSize:`、填充图层几何 `_fillLayerFrame:cornerRadius:` 还没读。
