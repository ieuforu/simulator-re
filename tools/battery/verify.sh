#!/bin/zsh
# 用还原规则重绘采集过的每个状态，并与真实截屏逐像素比对。
# 用法：verify.sh <17|27> <设备> <采集目录> <输出目录>
# 重绘的输入（电量、chargingState、省电、百分比）取自 sbbattery 导出的真实视图状态。
V=$1; D=$2; O=$3; R=$4; BIN=${0:A:h:h:h}/.build/battery
mkdir -p $R/cmp
args=()
for f in $O/*.txt; do t=$(basename $f .txt)
  [ -f $O/$t-screen.png ] || continue
  blk=$(python3 -c "import sys;print(open('$f').read().split('\n=== ')[1])")
  g() { echo "$blk" | awk -v k="$1" '$1==k{print $3; exit}'; }
  args+=($t $(g chargePercent) $(g chargingState) $(g saverModeActive) $(g showsPercentage))
done
xcrun simctl spawn $D $BIN/batrender $V $R ${args[@]} > $R/render.log 2>&1
for f in $O/*.txt; do t=$(basename $f .txt)
  [ -f $O/$t-screen.png ] || continue
  read X Y <<< $(python3 -c "import re;b=open('$f').read().split('\n=== ')[1];m=re.search(r'inScreen=\(([\d.]+),([\d.]+)',b);print(round(float(m.group(1))*3),round(float(m.group(2))*3))")
  printf "%-16s " $t; $BIN/compare $O/$t-screen.png $R/$t.png $X $Y $R/cmp/$t.png
done
