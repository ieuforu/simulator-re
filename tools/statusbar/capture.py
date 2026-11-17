#!/usr/bin/env python3
"""Capture an explicit test device, waiting for an observer acknowledgement."""
import argparse
import json
import pathlib
import subprocess
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("device")
p.add_argument("directory", type=pathlib.Path)
p.add_argument("tag")
p.add_argument("--inject", action="store_true")
a = p.parse_args()
if not a.tag or pathlib.Path(a.tag).name != a.tag:
    p.error("tag must be a single filename component")
root = pathlib.Path(__file__).resolve().parents[2]
out = a.directory.resolve()
out.mkdir(parents=True, exist_ok=True)


def sim(*args):
    return subprocess.run(["xcrun", "simctl", *map(str, args)], check=True)


if a.inject:
    library = root / ".build/statusbar/observer.dylib"
    if not library.exists():
        raise SystemExit("Build tools/statusbar first")
    sim("spawn", a.device, "launchctl", "debug", "system/com.apple.SpringBoard", "--environment",
        f"DYLD_INSERT_LIBRARIES={library}", f"STATUSBAR_AUDIT_DIR={out}")
    sim("spawn", a.device, "launchctl", "kickstart", "-k", "system/com.apple.SpringBoard")
dest = out / (a.tag + ".json")
dest.unlink(missing_ok=True)
(out / "trigger").write_text(a.tag)
deadline = time.monotonic() + 30
while not dest.exists():
    if time.monotonic() > deadline:
        raise SystemExit("Observer timed out; inspect SpringBoard before retrying")
    time.sleep(0.2)
data = json.loads(dest.read_text())
if a.tag == "methods":
    print("Recorded runtime method signatures")
else:
    visible = [i for i in data["icons"] if not i["hiddenInHierarchy"] and i["alphaInHierarchy"] > 0.01]
    # Overrides and relaunch are asynchronous. Retry snapshots (not CC actions)
    # until the system has actually populated the icon views.
    while not visible and a.tag not in ("cc-open", "cc-close") and time.monotonic() < deadline:
        time.sleep(1)
        dest.unlink(missing_ok=True)
        (out / "trigger").write_text(a.tag)
        while not dest.exists() and time.monotonic() < deadline:
            time.sleep(0.2)
        if not dest.exists():
            break
        data = json.loads(dest.read_text())
        visible = [i for i in data["icons"] if not i["hiddenInHierarchy"] and i["alphaInHierarchy"] > 0.01]
    if not visible:
        raise SystemExit("No visible icons; snapshot is not accepted as a stable state")
    if a.tag in ("cc-open", "cc-close") and data["controlCenterPresented"] != (a.tag == "cc-open"):
        raise SystemExit("Control Center did not reach the requested state")
    sim("io", a.device, "screenshot", out / (a.tag + "-screen.png"))
    print(f"iOS {data['systemVersion']}: {a.tag}, {len(visible)} visible icons, CC={data['controlCenterPresented']}")
