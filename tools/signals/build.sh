#!/bin/zsh
set -euo pipefail
T=${0:A:h}; R=${T:h:h}; O=$R/.build/signals
mkdir -p "$O"
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
SIM=(xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK"
     -framework UIKit -framework QuartzCore -framework CoreGraphics -framework Foundation)
$SIM -dynamiclib "$T/sbsignals.m" -o "$O/sbsignals.dylib"
$SIM "$T/signalprobe.m" -o "$O/signalprobe"
$SIM "$T/signalrender.m" -o "$O/signalrender"
for f in sbsignals.dylib signalprobe signalrender; do codesign -s - -f "$O/$f" 2>/dev/null; done
echo "已编译到 $O"
