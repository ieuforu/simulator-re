#!/usr/bin/env python3
"""Capture verified live status-bar state, its layers and a screenshot on an experimental simulator."""
import argparse
import json
import pathlib
import subprocess
import time

parser = argparse.ArgumentParser()
parser.add_argument("device")
parser.add_argument("directory", type=pathlib.Path)
parser.add_argument("tag")
parser.add_argument("--wifi", type=int, choices=range(4), default=3)
parser.add_argument("--cellular", type=int, choices=range(5), default=4)
parser.add_argument("--foreground-app", default="com.apple.Preferences", help="open an app to dismiss the respring overlay before capture")
parser.add_argument("--inject", action="store_true", help="restart SpringBoard with the observer; use only on experiment devices")
a = parser.parse_args()
if pathlib.Path(a.tag).name != a.tag or a.tag in ("", ".", ".."):
    parser.error("tag must be a simple file name")
root = pathlib.Path(__file__).resolve().parents[2]
out = a.directory.resolve()
out.mkdir(parents=True, exist_ok=True)

def sim(*args):
    subprocess.run(["xcrun", "simctl", *map(str, args)], check=True, stdout=subprocess.DEVNULL)

sim("status_bar", a.device, "override", "--time", "9:41", "--dataNetwork", "wifi",
    "--wifiMode", "active", "--wifiBars", a.wifi, "--cellularMode", "active",
    "--cellularBars", a.cellular, "--batteryState", "discharging", "--batteryLevel", "100")
if a.inject:
    sim("spawn", a.device, "launchctl", "debug", "system/com.apple.SpringBoard", "--environment",
        f"DYLD_INSERT_LIBRARIES={root}/.build/signals/sbsignals.dylib", f"SRSIGNAL_DIR={out}")
    sim("spawn", a.device, "launchctl", "kickstart", "-k", "system/com.apple.SpringBoard")

sim("launch", a.device, a.foreground_app)
# launch 返回时转场仍可能在进行；先留出转场时间，再核对实际信号状态。
# 截图仍需目视验收，图层存在本身不证明最终合成画面已稳定。
time.sleep(2)

dest = out / f"{a.tag}.json"
deadline = time.monotonic() + 40
matched = False
while time.monotonic() < deadline:
    dest.unlink(missing_ok=True)
    (out / "trigger").write_text(a.tag)
    for _ in range(20):
        if dest.exists():
            break
        time.sleep(0.1)
    if not dest.exists():
        continue
    data = json.loads(dest.read_text())
    icons = [i for i in data["icons"] if not i["hidden"] and i["alpha"] > 0.5]
    wanted = {"STUIStatusBarWifiSignalView": a.wifi, "STUIStatusBarCellularSignalView": a.cellular}
    matched = all(any(i["class"] == name and i["numberOfActiveBars"] == bars and i["signalMode"] == 2
                      for i in icons) for name, bars in wanted.items())
    if matched:
        break
    time.sleep(0.4)
if not matched:
    raise SystemExit(f"Status did not converge; inspect {dest}")
sim("io", a.device, "screenshot", out / f"{a.tag}-screen.png")
print(f"{data['model']} iOS {data['systemVersion']}: {a.tag}, wifi={a.wifi}, cellular={a.cellular}")
for i in icons:
    print(i["class"], "size=", i["iconSize"], "rounded=", i["rounded"], "frame=", i["screenFrame"])
