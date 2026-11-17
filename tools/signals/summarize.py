#!/usr/bin/env python3
"""Keep reproducible, address-free measurements; raw captures remain in .build/."""
import argparse
import json
import pathlib
import re

p = argparse.ArgumentParser()
p.add_argument("capture_root", type=pathlib.Path)
p.add_argument("output", type=pathlib.Path)
a = p.parse_args()

def read(path):
    return json.loads(path.read_text())

def clean_layer(layer):
    keys = ("class", "frame", "bounds", "cornerRadius", "cornerCurve", "opacity", "backgroundColor")
    out = {k: layer[k] for k in keys if k in layer}
    out["children"] = [clean_layer(c) for c in layer.get("children", [])]
    return out

result = {
    "scope": "iOS 17.4 (21E213), arm64 Simulator, portrait, default display settings, scale 3; not physical devices",
    "parameters": read(a.capture_root / "probe/parameters.json"),
    "captures": [],
    "verification": (a.capture_root / "verification.txt").read_text().strip().splitlines()[-1],
}
for model in ("notch", "island", "island-max"):
    for state in ("full", "partial"):
        source = read(a.capture_root / model / f"{state}.json")
        row = {k: source[k] for k in ("model", "systemVersion", "screenSize", "scale")}
        row.update(case=state, icons=[], statusBars=[], styleEvents=[])
        for v in source["icons"]:
            keys = ("class", "screenFrame", "intrinsicSize", "iconSize", "rounded", "signalMode",
                    "numberOfBars", "numberOfActiveBars", "activeColor", "inactiveColor", "barCornerRadius")
            icon = {k: v[k] for k in keys if k in v}
            icon["layer"] = clean_layer(v["layer"])
            row["icons"].append(icon)
        for v in source["layout"]:
            if v["class"] == "STUIStatusBar":
                row["statusBars"].append({"frame": v["screenFrame"],
                    "visualProvider": re.sub(r": 0x[0-9a-fA-F]+", "", v["visualProvider"])})
        for event in source["styleEvents"]:
            if event not in row["styleEvents"]:
                row["styleEvents"].append(event)
        # The hierarchy can contain multiple status-bar copies. Preserve them above;
        # report spacing from one complete cellular / Wi-Fi / battery triplet.
        cell = next(v for v in row["icons"] if v["class"] == "STUIStatusBarCellularSignalView")["screenFrame"]
        wifi = next(v for v in row["icons"] if v["class"] == "STUIStatusBarWifiSignalView")["screenFrame"]
        battery = next(v for v in row["icons"] if "BatteryView" in v["class"])["screenFrame"]
        row["frameGaps"] = {"cellularToWifi": wifi[0]-cell[0]-cell[2], "wifiToBattery": battery[0]-wifi[0]-wifi[2]}
        result["captures"].append(row)
a.output.parent.mkdir(parents=True, exist_ok=True)
a.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
