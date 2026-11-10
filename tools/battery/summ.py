# 汇总 sbbattery 导出的第一个电池视图：每个状态一行。用法：python3 summ.py <采集目录>
import re, sys, glob, os
def col(s):
    m = re.search(r'multiply=rgba\(([\d.]+),([\d.]+),([\d.]+),([\d.]+)\)', s)
    if not m: return '-'
    r,g,b,a = map(float, m.groups())
    name = {(0,0,0):'黑',(1,1,1):'白',(0.204,0.78,0.349):'绿',(1,0.22,0.235):'红',(1,0.8,0):'黄'}.get((round(r,3),round(g,3),round(b,3)), f'({r:.2f},{g:.2f},{b:.2f})')
    return f'{name}{"" if a==1 else f"α{a:g}"}'
def fr(s):
    m = re.search(r'frame=\(([-\d.]+),([-\d.]+) ([\d.]+)x([\d.]+)\)', s); return tuple(float(x) for x in m.groups())
def vis(s):
    return 'HIDDEN' if 'HIDDEN' in s else ('op0' if 'opacity=0.000' in s else 'on')
for f in sorted(glob.glob(sys.argv[1] + '/*.txt')):
    parts = open(f).read().split('\n=== ')
    if len(parts) < 2: continue
    t = parts[1]  # 第一个视图
    lines = [l for l in t.split('\n') if 'CALayer' in l or '_UILabelLayer' in l][1:]
    body, fill, pin = lines[0], lines[1], lines[2]
    rest = lines[3:]
    lab = next((l for l in rest if '_UILabelLayer' in l), '')
    bolts = [l for l in rest if 'contents=64x80' in l]   # 先蒙版层、后闪电层
    mask = bolts[0] if bolts else ''; bolt = bolts[1] if len(bolts) > 1 else ''
    out = [os.path.basename(f)[:-4].ljust(15), f'外壳{col(body)} {fr(body)[2]:.3f}x{fr(body)[3]:.3f}', f'填充{col(fill)} w={fr(fill)[2]:.3f}', f'凸头{col(pin)}']
    if lab:
        tx = re.search(r'text="([^"]*)"', lab).group(1); fn = re.search(r'font=(\S+) ([\d.]+)pt', lab)
        lc = re.search(r'color=rgba\(([\d.]+),([\d.]+),([\d.]+),([\d.]+)\)', lab)
        lcs = {('0.000','0.000','0.000'):'黑',('1.000','1.000','1.000'):'白'}.get(lc.groups()[:3], str(lc.groups()))
        out.append(f'字[{vis(lab)}] "{tx}" {fn.group(1).replace("SFProRoundedStatusBar-","")} {fn.group(2)} {lcs}{" 镂空" if "destOut" in lab else ""} @({fr(lab)[0]:.4f},{fr(lab)[1]:.4f} {fr(lab)[2]:.3f}x{fr(lab)[3]:.3f})')
    if bolt:
        sc = re.search(r'transform=\[([\d.]+)', bolt)
        out.append(f'闪电[{vis(bolt)}]{" 镂空" if "destOut" in bolt else ""} {col(bolt)} ×{float(sc.group(1)):.4f} @({fr(bolt)[0]:.4f},{fr(bolt)[1]:.4f} {fr(bolt)[2]:.3f}x{fr(bolt)[3]:.3f})')
    if mask: out.append(f'镂空层[{vis(mask)}]')
    print(' | '.join(out))
