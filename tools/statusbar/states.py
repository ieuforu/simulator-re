#!/usr/bin/env python3
"""Replay three battery/signal states on an explicitly selected test device."""
import argparse
import json
import pathlib
import subprocess
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("device")
p.add_argument("directory", type=pathlib.Path)
a = p.parse_args()
root = pathlib.Path(__file__).resolve().parents[2]
out = a.directory.resolve()


def sim(*args):
    return subprocess.run(["xcrun", "simctl", *map(str, args)], check=True, capture_output=True)


cases = [("charging", 40, 1, 0, 0, 2, 3, "light"),
         ("saver-percent", 50, 0, 1, 1, 1, 2, "light"),
         ("low-percent-dark", 20, 0, 0, 1, 3, 4, "dark")]
results = []
try:
    for tag, capacity, charging, saver, percent, wifi, cell, appearance in cases:
        sim("ui", a.device, "appearance", appearance)
        sim("status_bar", a.device, "clear")
        sim("status_bar", a.device, "override", "--wifiMode", "active", "--wifiBars", wifi,
            "--cellularMode", "active", "--cellularBars", cell, "--operatorName", "Carrier")
        # Publisher has a finite lifetime; wait for its own completion rather than
        # killing a simctl parent and potentially leaving the child alive.
        publisher = subprocess.Popen(["xcrun", "simctl", "spawn", a.device,
                                      str(root / ".build/battery/batovr"), str(capacity),
                                      str(charging), str(saver), str(percent), "10"],
                                     stdout=subprocess.DEVNULL)
        try:
            time.sleep(2)
            subprocess.run(["python3", str(root / "tools/statusbar/capture.py"),
                            a.device, str(out), tag], check=True)
            data = json.loads((out / f"{tag}.json").read_text())
            assert data["controlCenterPresented"] is False
            icons = [i for i in data["icons"] if not i["hiddenInHierarchy"] and i["alphaInHierarchy"] > .01]
            battery = next(i["battery"] for i in icons if "battery" in i)
            assert abs(battery["chargePercent"] - capacity / 100) < 1e-8, battery
            assert battery["chargingState"] == charging, battery
            assert battery["saverModeActive"] == bool(saver), battery
            assert battery["showsPercentage"] == bool(percent), battery
            assert next(i["numberOfActiveBars"] for i in icons if "Wifi" in i["class"]) == wifi
            assert next(i["numberOfActiveBars"] for i in icons if "Cellular" in i["class"]) == cell
            results.append({"tag": tag, "capacity": capacity, "charging": charging,
                            "saver": saver, "percentage": percent, "wifiBars": wifi,
                            "cellularBars": cell, "appearance": appearance, "passed": True})
        finally:
            code = publisher.wait(timeout=20)
            if code:
                raise RuntimeError(f"battery publisher exited {code}")
finally:
    sim("ui", a.device, "appearance", "light")
    sim("status_bar", a.device, "clear")
(out / "states-validation.json").write_text(json.dumps(results, indent=2) + "\n")
print(f"{a.device}: {len(results)} state checks passed")
