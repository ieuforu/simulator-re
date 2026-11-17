#!/usr/bin/env python3
"""Keep versioned measurements and validation results, not runtime inventories."""
import argparse
import hashlib
import json
import pathlib
import re

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("captures", type=pathlib.Path)
p.add_argument("output", type=pathlib.Path)
a = p.parse_args()
a.output.mkdir(parents=True, exist_ok=True)


def read(path):
    return json.loads(path.read_text())


def write(name, value):
    (a.output / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def visible(item):
    return not item["hiddenInHierarchy"] and item["alphaInHierarchy"] > .01


def clean(value):
    if isinstance(value, dict):
        return {k: clean(v) for k, v in value.items() if k not in ("image",)}
    if isinstance(value, list):
        return [clean(v) for v in value]
    return value


snapshots = []
for folder, version, build in [("17-4", "17.4", "21E213"), ("27-0", "27.0", "24A434")]:
    directory = a.captures / folder
    checks = read(directory / "states-validation.json")
    assert len(checks) == 3 and all(c["passed"] for c in checks)
    for tag in ("normal", "cc-open", "charging", "saver-percent", "low-percent-dark"):
        data = read(directory / f"{tag}.json")
        assert data["systemVersion"] == version
        data["build"] = build
        data["capture"] = tag
        data["icons"] = [clean(i) for i in data["icons"] if visible(i)]
        data["bars"] = [i for i in data["bars"] if visible(i)]
        data["texts"] = [i for i in data["texts"] if visible(i)]
        assert len(data["icons"]) == 3 and len(data["bars"]) == 1
        assert data["bars"][0]["mode"] == (1 if tag == "cc-open" else 0)
        assert data["controlCenterPresented"] == (tag == "cc-open")
        data["modeEvents"] = [{"mode": e["mode"], "stack": [
            re.sub(r"^\d+\s+(\S+)\s+0x[0-9a-f]+\s+", r"\1: ", s)
            for s in e["stack"]]} for e in data["modeEvents"]] if tag == "cc-open" else []
        data["screenshotSHA256"] = hashlib.sha256((directory / f"{tag}-screen.png").read_bytes()).hexdigest()
        snapshots.append(data)
    write(f"statusbar-{version}-states.json", checks)
write("statusbar-modes.json", {"scope": "simulator portrait; hierarchy visibility plus screenshot review; not a general occlusion detector", "snapshots": snapshots})
rules = read(a.captures / "27-0/rules.json")
assert len(rules["dynamicSelection"]) == 75 and len(rules["iconSizeMapping"]) == 96
assert all(x["actual"] == x["expected"] for group in ("dynamicSelection", "iconSizeMapping") for x in rules[group])
assert rules["wifiMaxParameterError"] < 1e-9
write("statusbar-27-rules.json", rules)
wifi = read(a.captures / "27-0/wifi-verify/validation.json")
cell = read(a.captures / "27-0/cell-validation.json")
assert len(wifi["cases"]) == 190 and wifi["worstRGBAByteDelta"] == 0
assert len(cell["cases"]) == 120 and cell["worstError"] < 1e-9
write("statusbar-27-wifi-validation.json", wifi)
write("statusbar-27-cell-validation.json", cell)
print("Accepted 10 screenshots, 6 state checks, 171 rules, 19 Wi-Fi parameter rows, 190 images, 480 cellular bars")
