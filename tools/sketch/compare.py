#!/usr/bin/env python3
"""Produce compact, addressable evidence for the two supplied Apple design kits."""
import argparse
import json
import pathlib

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("old", type=pathlib.Path)
p.add_argument("new", type=pathlib.Path)
p.add_argument("output", type=pathlib.Path)
a = p.parse_args()
old, new = [json.loads(p.read_text()) for p in (a.old, a.new)]


def normalized(component):
    def clean(value):
        if isinstance(value, dict):
            return {k: clean(v) for k, v in value.items() if k not in ("id", "symbolID", "swatchID")}
        if isinstance(value, list):
            return [clean(v) for v in value]
        return value
    return clean(component["layers"])


checks = []
for c in old["components"]:
    if not c["source"].endswith("/symbolMaster"):
        continue
    original = next(x for x in old["components"]
                    if x["source"] == c["source"].replace("/symbolMaster", "/originalMaster")
                    and x["name"] == c["name"])
    checks.append({"component": c["name"], "cachedMatchesOriginal": normalized(c) == normalized(original)})

sources = []
for d in (old, new):
    source = {k: v for k, v in d.items() if k != "components"}
    selected = []
    for c in d["components"]:
        if "originalMaster" in c["source"] or "Dark" in c["name"] or "Duo" in c["name"] or "iPhone" not in c["name"]:
            continue
        rows = []
        for row in c["layers"]:
            if any(s in row["path"] for s in ("Battery", "Wifi", "Cellular", "Time", "100%")):
                rows.append({k: v for k, v in row.items() if k not in ("fills", "overrides", "textAttributes")})
                if row.get("textAttributes"):
                    rows[-1]["fontAttributes"] = [x["attributes"].get("MSAttributedStringFontAttribute")
                                                  for x in row["textAttributes"]]
        selected.append({"source": c["source"], "name": c["name"], "componentFrame": c["layers"][0]["frame"], "layers": rows})
    source["components"] = selected
    sources.append(source)

report = {"sources": sources, "crossChecks": checks,
          "scope": "Measured Sketch layer properties only. No simulator equivalence or pixel identity is asserted."}
a.output.parent.mkdir(parents=True, exist_ok=True)
a.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
print(f"{len(checks)} cached/original comparisons: {sum(x['cachedMatchesOriginal'] for x in checks)} identical")
print(f"{sum(len(s['components']) for s in sources)} selected components -> {a.output}")
