#!/bin/zsh
set -euo pipefail
T=${0:A:h}; O=${T:h:h}/.build/statusbar
mkdir -p "$O"
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework QuartzCore -framework CoreGraphics -framework Foundation -dynamiclib \
  "$T/observer.m" -o "$O/observer.dylib"
codesign -s - -f "$O/observer.dylib" 2>/dev/null
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework Foundation "$T/runtimeprobe.m" -o "$O/runtimeprobe"
codesign -s - -f "$O/runtimeprobe" 2>/dev/null
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework CoreGraphics -framework Foundation "$T/rulesprobe.m" -o "$O/rulesprobe"
codesign -s - -f "$O/rulesprobe" 2>/dev/null
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework QuartzCore -framework CoreGraphics -framework Foundation "$T/wifiverify.m" -o "$O/wifiverify"
codesign -s - -f "$O/wifiverify" 2>/dev/null
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework QuartzCore -framework CoreGraphics -framework Foundation "$T/cellverify.m" -o "$O/cellverify"
codesign -s - -f "$O/cellverify" 2>/dev/null
echo "Built $O/observer.dylib"
