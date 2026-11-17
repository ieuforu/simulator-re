# 09 两份 Apple Sketch：普通状态栏与控制中心

本篇记录用户提供的 iOS 27 UI Kit，以及从 Apple CDN 下载的 iOS 18 Templates + Guides。
**设计文件的参数不是系统运行时的参数；文件名中的版本也不是模拟器验证结果。**
系统对照与新的控制中心链路见 [10](10-statusbar-modes.md)。

## 来源与复现

- iOS 18：`Templates + Guides.sketch`，来自 [Apple 官方 DMG](https://devimages-cdn.apple.com/design/resources/download/iOS-18-Design-Templates-Sketch.dmg)。不是独立全量 UI Kit，但包含来自 `Apple iOS UI` 的本地缓存 symbol master 和 original master。
- iOS 27：用户下载的 `Apple iOS 27 UI Kit.sketch`。
- 原稿不修改、不放入 Git。原稿 SHA-256、Sketch 保存版本、组件在 archive 中的位置和图层 ID 见 [设计稿测量证据](evidence/sketch-status-bars.json)。路径控制点仅保留摘要哈希，不重新分发完整设计资源。
- `appVersion` 指保存文件的 Sketch 版本，不能当作 iOS 版本或发布日期。
- iOS 18 中 10 组相关 cached symbolMaster / originalMaster 的测量记录一致；比较忽略本地 ID、symbolID、swatchID 的重映射，保留几何、路径摘要和颜色值。不是仅根据同名组件判定一致。

```sh
python3 tools/sketch/extract.py '/path/to/Templates + Guides.sketch' .build/statusbar/sketch18.json
python3 tools/sketch/extract.py '/path/to/Apple iOS 27 UI Kit.sketch' .build/statusbar/sketch27.json
python3 tools/sketch/compare.py .build/statusbar/sketch18.json .build/statusbar/sketch27.json notes/evidence/sketch-status-bars.json
```

解析依据是 Sketch 的 [公开文件格式](https://developer.sketch.com/file-format/)。坐标是相对直接父图层的画布单位；转换到屏幕 pt、像素或可见轮廓之前，必须先处理嵌套变换、符号实例缩放和描边位置。本文没有运行 Sketch 原生渲染器，不声称图层框就是最终可见像素边界。

## iOS 18：用户记忆的三个数字找到了

| 参数 | `Status Bars/Light/iPhone` | `Templates/Control Center/Light/iPhone/Status Bar` |
|---|---:|---:|
| 电池 group | 27.228038 × 13 | 29.316049 × 14 |
| Border 外框 | 25 × 13 | 27 × 14 |
| Border 圆角字段 | 4.30000019073486 | 5 |
| Border 启用描边 | 1，position=1 | 1，position=1 |
| Capacity 填充 | 21 × 9 | 23 × 10 |
| Capacity 圆角字段 | 2.5 | 3.32999992370606 |
| 填充位置 | (1.8, 2) | (1.975610, 2) |

**3.33 是控制中心顶部电池内部填充的圆角，2.5 是普通状态栏填充圆角；普通外框保存的是 4.3，不能擅自改写成 4⅓。**
对应浅色 / 深色组件中的这些数值相同。控制中心填充还保存了 thickness=2.5 的 border，但 `isEnabled=false`，它不参与实际绘制，不能把这条停用描边与 cornerRadius=3.33 混为一谈。

普通状态栏时间为 `9:41`。控制中心右侧是独立 `100%` 文本 + 电池；不是把百分比写入电池内部。控制中心快捷按钮 `Controls/1x1 - Battery` 是另一个图标，不属于本表。

### 凸头确实保留了布尔结构，但在控制中心组件里

普通电池的 `Cap` 是已展开的 shapePath，宽 1.328038、高 4；其本地位置为 (25.9, 4.666667)。这些是不完全居中的设计稿数值，不能静默修正为系统公式。

控制中心的 `Combined Shape` 有两个子图层：

| 子图层 | 类型 | x, y | 宽 × 高 | booleanOperation |
|---|---|---|---|---|
| Oval 3 | oval | -3.622975, -0.326644 | 4.939024 × 5.653287 | 1 |
| Rectangle 11 | rectangle | -4.281512, -1.080415 | 4.280488 × 7.160830 | 1 |

Sketch 的 [官方枚举](https://raw.githubusercontent.com/sketch-hq/sketch-file-format/master/packages/file-format/schema/enums/boolean-operation.schema.yaml) 中 1 是 Subtract，2 才是 Intersection。
这里保存的是椭圆与矩形的减法结构，椭圆宽高也不相等，不能称为严格的圆。矩形从椭圆左侧裁去一块，留下右端圆弧片；最终 group 宽约 1.316049、高 5。
这与第 06 篇系统 `pin` 的圆弧切片在构形思路上相近，但**不能认定两套参数或控制点相同**。

### 旧稿的信号与时间

- Wi-Fi group 为 17.141680 × 12.1，由三条已展开填充路径构成，没有可直接读取的统一圆角参数。
- 蜂窝 group 为 19.2 × 12；四根路径宽均 3.2，高度从左到右为 4.6、7、9.6、12；x 为 0、5.3、10.7、16，三处空隙为 2.1、2.2、2.1。
- 普通状态栏：蜂窝 group x=288、Wi-Fi x=314.7、电池 x=340。相邻 group 间距分别为 7.5、8.158320，不是简单的同一常数。
- 控制中心的状态栏 group 高 130；普通 symbol 高 56。这是设计组件边界，不是安全区高度。

## iOS 27：普通组件与控制中心仍要分别读

| 参数 | iPhone 17 Pro 普通组件 | iPhone 18 Pro Max 普通组件 |
|---|---:|---:|
| 组件框 | 402 × 62 | 440 × 62 |
| Battery group | 29.333 × 13.667 | 32 × 15 |
| Body 路径框 | 26.3333 × 13.66666 | 29 × 15 |
| Contact 路径框 | 2 × 5 | 2 × 5 |
| Body → Contact 的名义间距 | 1 | 1 |
| Wi-Fi group | 19.333 × 14.333 | 20.667 × 15.333 |
| Cellular group | 20.322 × 15 | 20.322 × 16.333 |
| 每柱宽 / 柱间距 | 3.333 / 2.330 | 3.333 / 2.330 |
| 相邻图标 group 间距 | 8 / 8 | 8 / 8 |
| 时间 SFPro-Semibold 字号 | 17.67 | 18.67 |

表中机型名是文件里的组件名，不是本次对这些机型都做过运行时验证。iPhone 18 Pro 普通组件的右侧图标尺寸与该稿 iPhone 17 Pro 相同。

蜂窝 Bar 仍是 rectangle，保存 `radii=[4]`、`smoothing=0.6`。Sketch 官方说明，过大的半径会按比例缩小以适应形状，Smooth 样式还带平滑控制。因此 **保存值 4 不是实际端帽圆的半径，更不能直接作为 UIKit 的 cornerRadius**。参见 [Sketch Corners](https://www.sketch.com/docs/symbols-and-styles/styling/corners/)。

Body 有 44 个路径点，Contact 有 5 个路径点；Wi-Fi 各带为已展开路径。这些路径的 point.cornerRadius=0 不等于方角，它们的弯曲已经编码进曲线控制柄。

### 控制中心里的框不是实际绘图边界

该稿 `System/Control Center/Light/iPhone/Status Bar` 的顶部区域高 112；信号和电量行 y=97.67。右侧仍是独立 `100%` 文本 + Battery。

- Battery group 标称 28 × 13.333。
- Body 子路径却从 x=-2.67 开始，宽 27.67、高 13.67，越出了 group 原点。
- Contact 子路径约 1.333 × 4.102462，x=26。
- Wi-Fi 外层 group 宽 16.655，而内部 shapeGroup 宽 16.666。

因此自动对照必须保留层级，不能用 group 宽高代替所有子路径联合后的范围。这里也不能沿用普通状态栏的 2×5 凸头参数。

## 对照纪律

1. 先确认同一版本、同一机型、同一界面、同一电池状态，再谈误差。
2. 区分图层框、路径框、描边中心线、实际可见像素、系统 view frame。
3. 区分保存的圆角参数、平滑曲线、最终曲率；不用一个“半径”解释全部。
4. 系统端以原生路径 / 图层 / 截图为准；设计稿数值单独记录，不反向强改系统还原代码。
5. 未获取 iOS 18 运行时前，不能用 iOS 17.4 的动态证据替代 iOS 18。当前 iOS 18.5 arm64/universal 与 18.6 的 `xcodebuild -downloadPlatform` 请求均返回不可下载。
