#!/bin/zsh
# 编译电池工具，产物放在 .build/battery/（不入库）。
set -e
T=${0:A:h}; R=${T:h:h}; O=$R/.build/battery
mkdir -p $O
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
SIM=(xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot $SDK
     -framework UIKit -framework QuartzCore -framework CoreGraphics -framework Foundation)

# 注入 SpringBoard 的只读导出库
$SIM -dynamiclib $T/sbbattery.m -o $O/sbbattery.dylib
# 发布电池覆盖：权限必须放在 __TEXT,__entitlements 段（见 notes/02 的 04 节）
$SIM $T/batovr.m -o $O/batovr -Wl,-sectcreate,__TEXT,__entitlements,$R/tools/ovrtest/ent.plist
# 按 iconSize 导出参数表
$SIM $T/iconsizes.m -o $O/iconsizes
# 按还原规则独立重绘
$SIM $T/batrender.m -o $O/batrender
for f in sbbattery.dylib batovr iconsizes batrender; do codesign -s - -f $O/$f 2>/dev/null; done
# 主机端比对
xcrun swiftc -O $T/compare.swift -o $O/compare
echo "已编译到 $O"
