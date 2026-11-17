#!/usr/bin/env python3
"""Read status-bar geometry from a Sketch archive without modifying the source.

Exports measurements and provenance, not the complete Apple UI kit or artwork.
Both local cached symbols and their original masters are indexed explicitly.
"""
import argparse
import hashlib
import json
import pathlib
import re
import zipfile


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def walk(node, path=()):
    path = (*path, node.get("name", ""))
    yield node, path
    for child in node.get("layers", []):
        yield from walk(child, path)


def measure(node, path):
    style = node.get("style", {})
    points = node.get("points", [])
    f = node.get("frame", {})
    row = {
        "path": "/".join(path), "id": node.get("do_objectID"),
        "class": node.get("_class"), "symbolID": node.get("symbolID"),
        "frame": {k: f[k] for k in ("x", "y", "width", "height") if k in f},
        "visible": node.get("isVisible", True), "rotation": node.get("rotation", 0),
        "booleanOperation": node.get("booleanOperation"),
        "cornerRadii": sorted({p.get("cornerRadius", 0) for p in points}),
        "corners": style.get("corners"), "pointCount": len(points),
        "pathDigest": digest(points) if points else None,
        "borders": [{k: b.get(k) for k in ("isEnabled", "thickness", "position", "color")}
                    for b in style.get("borders", [])],
        "opacity": style.get("contextSettings", {}).get("opacity", 1),
        "fills": [{k: b.get(k) for k in ("isEnabled", "fillType", "color")}
                  for b in style.get("fills", [])],
    }
    if node.get("_class") == "text":
        a = node.get("attributedString", {})
        row["text"] = a.get("string")
        row["textAttributes"] = a.get("attributes")
    if node.get("overrideValues"):
        row["overrides"] = node["overrideValues"]
    return row


def extract(path):
    with zipfile.ZipFile(path) as archive:
        meta = json.loads(archive.read("meta.json"))
        doc = json.loads(archive.read("document.json"))
        roots = [(p["_ref"] + ".json", json.loads(archive.read(p["_ref"] + ".json")))
                 for p in doc["pages"]]
        for i, symbol in enumerate(doc.get("foreignSymbols", [])):
            for key in ("symbolMaster", "originalMaster"):
                if key in symbol:
                    roots.append((f"document.json/foreignSymbols/{i}/{key}", symbol[key]))
        components = []
        for source, root in roots:
            for node, chain in walk(root):
                name = node.get("name", "")
                # Full masters + inline Control Center status bars. Instances are
                # recorded as references; their bounds are not mistaken for masters.
                master = node.get("_class") == "symbolMaster" and name.startswith("Status Bars/")
                cc = any("Control Center" in s for s in chain) and name.lower() == "status bar"
                if not (master or cc):
                    continue
                components.append({"source": source, "name": "/".join(chain),
                                   "layers": [measure(n, p) for n, p in walk(node)]})
        return {"schema": 1, "file": path.name, "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                "sketchVersion": meta.get("appVersion"), "formatVersion": meta.get("version"),
                "pageCount": len(doc["pages"]), "foreignSymbolCount": len(doc.get("foreignSymbols", [])),
                "units": "Sketch canvas units; frames are relative to immediate parent",
                "limits": "Stored parameters, not a Sketch renderer result. Curves may be flattened; radius 0 does not imply square corners.",
                "components": components}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("sketch", type=pathlib.Path)
    p.add_argument("output", type=pathlib.Path)
    a = p.parse_args()
    result = extract(a.sketch)
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(f"{a.sketch.name}: {len(result['components'])} component records -> {a.output}")


if __name__ == "__main__":
    main()
