#!/usr/bin/env python3
"""Collect selection inputs and applied styles on an explicit experiment UDID."""
import argparse
import json
import pathlib
import subprocess
import time

p = argparse.ArgumentParser()
p.add_argument("device")
p.add_argument("directory", type=pathlib.Path)
p.add_argument("--inject", action="store_true")
a = p.parse_args()
root = pathlib.Path(__file__).resolve().parents[2]
out = a.directory.resolve()
out.mkdir(parents=True, exist_ok=True)

def sim(*args):
    return subprocess.run(["xcrun", "simctl", *map(str, args)], check=True)

sim("spawn", a.device, root / ".build/providers/providerprobe", out)
sim("status_bar", a.device, "override", "--time", "9:41", "--dataNetwork", "wifi",
    "--wifiMode", "active", "--wifiBars", "3", "--cellularMode", "active", "--cellularBars", "4",
    "--batteryState", "discharging", "--batteryLevel", "100")
if a.inject:
    sim("spawn", a.device, "launchctl", "debug", "system/com.apple.SpringBoard", "--environment",
        f"DYLD_INSERT_LIBRARIES={root}/.build/providers/sbproviders.dylib", f"PRPROVIDER_DIR={out}")
    sim("spawn", a.device, "launchctl", "kickstart", "-k", "system/com.apple.SpringBoard")
sim("launch", a.device, "com.apple.Preferences")
time.sleep(2)
dest = out / "live.json"
for attempt in range(20):
    dest.unlink(missing_ok=True)
    (out / "trigger").write_text("live")
    for _ in range(20):
        if dest.exists():
            break
        time.sleep(0.1)
    if not dest.exists():
        continue
    data = json.loads(dest.read_text())
    applied = [i for b in data["statusBars"] for i in b["items"] if i["lastAppliedStyle"]]
    kinds = {i["view"] for i in applied}
    if {"STUIStatusBarCellularSignalView", "STUIStatusBarWifiSignalView"} <= kinds and any("BatteryView" in k for k in kinds):
        print(f"Captured {data['model']}: {len(applied)} applied signal/battery styles")
        break
else:
    raise SystemExit("Applied styles did not converge; inspect live.json")
