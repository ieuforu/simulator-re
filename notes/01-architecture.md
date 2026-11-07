# 01 架构摸底

环境：Xcode 27.1 (27A9275) / CoreSimulator 1174.9.2 / macOS 27.3 arm64 / SIP 开启。
方法：只做静态分析（`otool`、`nm`、`strings`、`ipsw class-dump`），本阶段没有启动设备。

标记：**[已证实]** 由二进制直接确认；**[推测]** 待阶段 2 之后验证。

## 分层

```
simctl（Xcode 里的 shell 包装）          DeviceHub.app (com.apple.dt.Devices)
  └─ Resources/bin/simctl（真正的 Mach-O）   └─ DeviceKit（1250 万字节，无 SimulatorKit 依赖）
        │                                         └─ CoreDevice / UniversalHID / VNC / AVConference
        │
PreviewsDeveloperTools, UVTestSupport
        └─ SimulatorKit（UI 层：SimDisplayView、HID 客户端、IndigoHIDMessageFor*）
                │
        CoreSimulator（SimServiceContext / SimDeviceSet / SimDevice）
          ├─ CoreSimDeviceIO（IO 端口、屏幕和 HID 描述符；基于 ROCKit）
          ├─ SimFramebuffer / SimFramebufferServer（SFBConnection、SFBDisplay、交换链）
          └─ XPC ─ com.apple.CoreSimulator.CoreSimulatorService
                     ├─ SimulatorTrampoline
                     ├─ SimLaunchHost.arm64 / .x86
                     └─ simdiskimaged（挂载 runtime 磁盘镜像）
```

## 发现

| # | 发现 | 证据 | 状态 |
|---|---|---|---|
| 1 | Xcode 27 里没有 Simulator.app，新增了 `DeviceHub.app` | 全盘 `find`、`mdfind` 均无结果；DeviceHub 的字符串里有 "Stop simulators on quit" | 已证实 |
| 2 | DeviceHub 不直接依赖 SimulatorKit | `DeviceKit` 的 `otool -L` 和 `strings` 都没有相关引用，依赖的是 CoreDevice 和 UniversalHID | 已证实 |
| 3 | DeviceHub 的屏幕和输入可能走新链路 | 有 `VNCDisplayViewFramebufferProvider`、`DisplayViewFramebufferProviderAVC`、`BuiltInDisplayViewFramebufferProviderCreators`、`SyntheticTouchEventProcessor` | 推测 |
| 4 | `simctl` 是 shell 包装，先做版本检查，再 exec 到框架内的二进制 | 包装脚本内容 | 已证实 |
| 5 | 设备启动入口是 `-[SimDevice bootWithOptions:error:]`，另有异步版本 | `SimDevice.h` | 已证实 |
| 6 | 服务入口是 `+[SimServiceContext sharedServiceContextForDeveloperDir:error:]` | `SimServiceContext.h` | 已证实 |
| 7 | 显示协议在 CoreSimDeviceIO（`SimDisplayIOSurfaceRenderable` 等），底层是 IOSurface | 协议头文件 | 已证实 |
| 8 | SimFramebuffer 导出纯 C API：`SFBConnectionCreate`、`SFBConnectionConnect`、`SFBDisplayCreateSwapchain` | `nm` | 已证实 |
| 9 | 旧版输入链路仍在：`SimDeviceLegacyHIDClient` 发送 `IndigoHIDMessageStruct` | 类头文件和 Swift 符号 | 已证实 |
| 10 | SimulatorKit 导出 `IndigoHIDMessageFor*` 这组 C 函数，可用来构造按钮、键盘、滚动等消息 | `nm` | 已证实 |
| 11 | `IndigoHIDMessageStruct` 的完整布局已包含在 ObjC 类型编码里，含 `_touch_event` | 类头文件 | 已证实（字段含义待逆向） |

## 对之前路线的修正

- 显示不在 SimulatorKit。真正的数据源在 CoreSimDeviceIO 和 SimFramebuffer，SimulatorKit 只是视图层。
- `SimulatorKit` 仍在 Xcode 里，所以工具可以继续走旧链路。
- 新增研究目标：DeviceHub 如何连接模拟器（CoreDevice、VNC 或其他方式）。

## 下一步（阶段 2）

1. `dlopen` CoreSimulator，通过 `SimServiceContext` 列出设备。
2. 用 `bootWithOptions:error:` 启动设备，并轮询状态。
3. 启动后运行 `simctl io <device> enumerate`，核对实际的 IO 端口，验证发现 3 和 7。

# 02 阶段 2 结果：自己启动设备

CLI：`Sources/simre`，运行时 `dlopen` CoreSimulator，通过 `objc_msgSend` 调用，不链接私有框架，也不调用 `simctl`。

| # | 发现 | 证据 | 状态 |
|---|---|---|---|
| 12 | 调用链可用：`SimServiceContext` → `defaultDeviceSetWithError:` → `availableDevices` → `bootWithOptions:error:` | `simre list` 与 `simctl` 均为 15 台；`simre boot` 后 `simctl` 显示 Booted，截图有桌面 | 已证实 |
| 13 | 启动选项 `persist: true` 能让设备在客户端退出后继续运行 | CLI 退出后设备仍是 Booted | 已证实 |
| 14 | `bootWithOptions:error:` 是同步的，返回时 `state` 已是 Booted，但系统还没就绪 | 调用约 0.7s，之后 bootStatus 才开始跳变 | 已证实 |
| 15 | `bootStatus` 终态只代表系统应用已启动，**不代表桌面已显示** | 3 次重启：终态约 3.5s，之后 6-9s 截图才是桌面 | 已证实（3 次） |
| 15a | `bootStatus` 只有持续监听才可靠。新进程读到的是缓存：关机状态和苹果 logo 阶段都显示 terminal=1 | 16 次跨进程采样全部不变；发起启动的进程能看到 0 → 2 → 4 → 终态 | 已证实 |
| 15b | status=4 对应 `Waiting on System App` | `simctl bootstatus` 输出 | 已证实 |
| 16 | 首次启动明显更慢 | `simctl bootstatus` 记录 24s | 单次观察 |
| 17 | SpringBoard 和 backboardd 的父进程是 `launchd_sim`，后者由 launchd 托管（PPID 1），都是普通 macOS 进程 | `ps` | 已证实 |
| 18 | 主屏是 `com.apple.framebuffer.display`：1206×2622、BGRA，每行 4864 字节（不等于 宽×4 = 4824，读取时必须按 bytes per row） | `simctl io enumerate` | 已证实 |

备注：
- `Status=4294967295` 即 `0xFFFFFFFF`，对应 `Finished`。
- 有一次同时跑 `simctl bootstatus` 和 `notifyutil` 时，桌面反而早于终态出现，原因不明，不作为结论。
- `simctl io screenshot` 本身耗时 1-3s，上面的时间都有这个量级的误差。
- 更正：本节最初把“就绪后截图正常”记为已证实，实际截图是苹果 logo，已改为发现 15。
- 真正判断桌面是否显示，要等阶段 3 能读帧缓冲之后再做。
