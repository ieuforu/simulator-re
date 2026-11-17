#!/bin/zsh
set -euo pipefail
T=${0:A:h}; R=${T:h:h}; O=$R/.build/providers
mkdir -p "$O"
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework Foundation -framework CoreGraphics "$T/providerprobe.m" -o "$O/providerprobe"
codesign -s - -f "$O/providerprobe" 2>/dev/null
xcrun clang -fobjc-arc -target arm64-apple-ios17.0-simulator -isysroot "$SDK" \
  -framework UIKit -framework Foundation -dynamiclib "$T/sbproviders.m" -o "$O/sbproviders.dylib"
codesign -s - -f "$O/sbproviders.dylib" 2>/dev/null
echo "Built $O/providerprobe"
