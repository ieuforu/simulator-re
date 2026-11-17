#!/usr/bin/env python3
"""Verify native branch tests and the live provider -> overrides -> view chain."""
import argparse
import json
import pathlib

p = argparse.ArgumentParser()
p.add_argument("capture_root", type=pathlib.Path)
p.add_argument("--evidence", type=pathlib.Path)
a = p.parse_args()
tests = ("notchSelectionTests", "phoneFamilyTests", "dynamicBoundaryTests", "iconSizeTests")
models = {
    "notch": ("iPhone14,7", "STUIStatusBarVisualProvider_Split1170", 1.06, 4, 15.5, None),
    "island": ("iPhone16,1", "STUIStatusBarVisualProvider_DynamicSplitMedium", 1.12, 7, 17, 15),
    "island-max": ("iPhone16,2", "STUIStatusBarVisualProvider_DynamicSplit", 1.26, 8, 18, 16),
}
evidence = {"runtime": "iOS 17.4 (21E213), arm64 Simulator, default portrait settings",
            "devices": [], "branchTests": {}, "validation": {}}
test_count = style_count = 0
for tag, (model, provider, icon_scale, icon_size, signal_font_size, battery_font_size) in models.items():
    probe = json.loads((a.capture_root / tag / "probe.json").read_text())
    live = json.loads((a.capture_root / tag / "live.json").read_text())
    assert probe["model"] == live["model"] == model
    assert probe["systemVersion"] == live["systemVersion"] == "17.4"
    assert probe["selectedProvider"] == provider
    count = 0
    for key in tests:
        rows = probe[key]
        assert rows and all(row["actual"] == row["expected"] for row in rows), (tag, key)
        if key in evidence["branchTests"]:
            assert rows == evidence["branchTests"][key]
        else:
            evidence["branchTests"][key] = rows
        count += len(rows)
    assert count == 172
    test_count += count
    device = {"model": model, "screen": probe["screen"], "selectedProvider": provider, "statusBars": []}
    local_styles = 0
    for bar in live["statusBars"]:
        assert bar["provider"] == provider
        values = bar["providerValues"]
        assert values["normalIconScale"] == icon_scale and values["normalIconSize"] == icon_size
        assert bar["mode"] == 0
        kept = []
        for item in bar["items"]:
            applied = item["lastAppliedStyle"]
            if not applied:
                continue  # Constructed but not applied/off-layout states are not live evidence.
            assert applied == item["mergedStyle"], (tag, item["view"])
            assert applied["iconSize"] == item["viewIconSize"] == icon_size
            assert applied["iconScale"] == icon_scale
            assert applied["rounded"] == item["viewRounded"]
            assert item["regionOverride"]["font"] == {"name": ".SFUI-Semibold", "size": signal_font_size}
            rounded = "BatteryView" in item["view"] and battery_font_size is not None
            assert item["viewRounded"] == rounded
            expected_font = {"name": ".AppleSystemUIFontRounded-Medium" if rounded else ".SFUI-Semibold",
                             "size": battery_font_size if rounded else signal_font_size}
            assert applied["font"] == expected_font
            assert (item["providerOverride"].get("font") if rounded else item["providerOverride"]) == (expected_font if rounded else {})
            kept.append(item)
            local_styles += 1
        assert len(kept) == 3
        device["statusBars"].append({**bar, "items": kept})
    assert local_styles == 6
    style_count += local_styles
    evidence["devices"].append(device)
    print(f"{tag}: {count} native branch cases; {local_styles} applied styles match selection, merge, font and view flags")
evidence["notchCandidates"] = probe["notchCandidates"]
evidence["validation"] = {"uniqueBranchCases": 172, "deviceRuns": 3,
                          "nativeComparisons": test_count, "appliedStyleComparisons": style_count}
if a.evidence:
    a.evidence.parent.mkdir(parents=True, exist_ok=True)
    a.evidence.write_text(json.dumps(evidence, ensure_ascii=False, indent=2) + "\n")
print(f"PASS: {test_count} native comparisons (172 cases x 3 devices), {style_count} applied styles")
