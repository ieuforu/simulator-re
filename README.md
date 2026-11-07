# simulator-re

学习用途：逆向 iOS Simulator 的架构，并写一个不依赖 Simulator.app 的 Swift 小工具。

- `notes/`：逆向笔记
- `dumps/`：本地导出的头文件和符号（不入库）

## 用法

```sh
swift build
.build/debug/simre list
.build/debug/simre boot <名称或UDID>
.build/debug/simre state <名称或UDID>
.build/debug/simre shutdown <名称或UDID>
.build/debug/simre statusbar <设备> time 9:41
.build/debug/simre statusbar <设备> battery 2 42
.build/debug/simre statusbar <设备> wifi 3 1
.build/debug/simre statusbar <设备> cellular 3 运营商 2
.build/debug/simre statusbar <设备> clear
```

枚举值见 `notes/02-status-bar.md`。

## StatusBarLab

模拟器内的状态栏调试 App，用按钮调整时间、电池、Wi-Fi 和蜂窝网络，包括 `simctl` 做不到的低电量模式。

```sh
open apps/StatusBarLab/StatusBarLab.xcodeproj   # 选模拟器后运行
```

命令行构建和测试：

```sh
xcodebuild -project apps/StatusBarLab/StatusBarLab.xcodeproj -scheme StatusBarLab \
  -destination 'platform=iOS Simulator,name=simre-test' -derivedDataPath .build/DerivedData test
```

只支持模拟器，只在 iOS 27.0 上验证过。它依赖私有框架，不能上架。
