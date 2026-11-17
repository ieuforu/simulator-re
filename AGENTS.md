# simulator-re

个人学习项目：逆向 iOS Simulator、SpringBoard 状态栏和图标绘制。工作前先读 [README 当前状态](README.md#当前状态)，再核对分支、HEAD 和工作区；具体证据按需读 `notes/`。

## 目录与命令

- `Sources/simre/`：macOS Swift CLI；`swift build`。
- `apps/StatusBarLab/`：原生 SwiftUI 实验 App，用 Xcode 打开其中的 `.xcodeproj`。
- `tools/battery/`：电池探针、独立重绘、比对和图解；`zsh tools/battery/build.sh`。
- `tools/simprobe/`、`tools/sbtrace/`、`tools/lldb/`：运行时内省、注入和反汇编辅助。
- `tools/signals/`：Wi-Fi / 蜂窝信号研究工具，具体命令见该阶段的笔记。
- `tools/providers/`：provider 选型、iconSize 映射、逐项目样式采集与原生方法验证；`zsh tools/providers/build.sh`，复现见 `notes/08-provider-selection.md`。
- `tools/sketch/`：只读提取 Sketch 的状态栏层级、几何、路径摘要及来源哈希；命令见 `notes/09-sketch-status-bars.md`。原始 UI Kit / DMG 不入库。
- `tools/statusbar/`：17.4 / 27 控制中心模式采集、27 provider / 新信号验证和图解；`zsh tools/statusbar/build.sh`，完整复现见 `notes/10-statusbar-modes.md`。
- `notes/`：方法、实测结论及限制；`notes/evidence/` 保存可复核的文本证据。
- `.build/`、`dumps/`：不提交的构建产物和实验采集。不要提交 Apple 二进制、导出的框架头文件或凭据。

## 研究约束

- 清楚标明运行时版本、设备、倍率、状态、实测与推断；不能把模拟器采集称为真机验证。
- 还原代码不是 Apple 原始源码。不能把某个版本的私有 API、枚举档位或 ivar 偏移当作跨版本保证。
- 几何验证优先比较系统实际路径、图层和截图；不只与另一个手写公式互相验证。
- 使用临时实验设备时记录 UDID，完成后清理自己创建的设备；不要关掉或删除用户原有的运行设备。
- 避免无关的 `xcodebuild test`：历史上在 DeviceHub 打开时曾影响其他模拟器。
- 当前状态统一维护在 README，不另建逐日交接文件。阶段结束同步有效结论、已执行验证、限制和下一步。
- 提交、推送、部署按本次用户授权执行；历史发布授权不扩展到新任务。
