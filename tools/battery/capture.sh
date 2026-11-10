#!/bin/zsh
# 采集真实状态栏电池：发布覆盖 → 等状态栏更新 → 让注入的 sbbattery 导出视图 → 截屏并裁出电池。
#
# 前提：SpringBoard 已注入 sbbattery.dylib，且 SBBATTERY_DIR 指向 <采集目录>：
#   xcrun simctl spawn <设备> launchctl debug system/com.apple.SpringBoard \
#     --environment DYLD_INSERT_LIBRARIES=<仓库>/.build/battery/sbbattery.dylib SBBATTERY_DIR=<采集目录>
#   xcrun simctl spawn <设备> launchctl kickstart -k system/com.apple.SpringBoard
# 用完再 kickstart 一次即可去掉注入（debug 配置只作用于下一次启动）。
#
# 用法：capture.sh <设备> <采集目录> <标签> <capacity 0-100> <state 0-4> <saver 0/1> <showPercent 0/1>
#   state 是数据层枚举：0 放电，1 充电，2 已充满，3 未充电，4 无法充电
zmodload zsh/mathfunc
D=$1; O=$2; T=$3; BIN=${0:A:h:h:h}/.build/battery
xcrun simctl spawn $D $BIN/batovr $4 $5 $6 $7 8 > /dev/null 2>&1 &
sleep 2.5
echo $T > $O/trigger
for i in {1..30}; do [ -f $O/$T.txt ] && break; sleep 0.3; done
xcrun simctl io $D screenshot $O/$T-screen.png > /dev/null 2>&1
# 电池在屏幕上的位置（pt）→ 像素，四周各留 4pt
read X Y W H <<< $(grep -m1 -oE "inScreen=\([0-9.]+,[0-9.]+ [0-9.]+x[0-9.]+" $O/$T.txt | sed -E 's/inScreen=\(//; s/[,x]/ /g')
S=3; PX=$(( int((X - 4) * S) )); PY=$(( int((Y - 4) * S) )); PW=$(( int((W + 8) * S) )); PH=$(( int((H + 8) * S) ))
sips -c $PH $PW --cropOffset $PY $PX $O/$T-screen.png --out $O/$T-crop.png > /dev/null 2>&1
wait
echo "$T: $(grep -m1 -oE 'inScreen=[^ ]+ [^ ]+' $O/$T.txt) pct=$(grep -m1 'showsPercentage =' $O/$T.txt | awk '{print $3}') state=$(grep -m1 'chargingState =' $O/$T.txt | awk '{print $3}')"
