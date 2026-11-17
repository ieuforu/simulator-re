#!/usr/bin/env python3
"""Export version-matched methods and follow the four Wi-Fi Swift thunks."""
import argparse
import json
import pathlib
import re
import shlex
import subprocess
import tempfile

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("pid", type=int)
p.add_argument("runtime_directory", type=pathlib.Path)
p.add_argument("output", type=pathlib.Path)
a = p.parse_args()
root = pathlib.Path(__file__).resolve().parents[2]
runtime = a.runtime_directory.resolve()
version = json.loads((runtime / "runtime.json").read_text())["version"]
if version not in ("17.4", "27.0"):
    p.error("Only the two audited runtime versions have method lists")


def export(methods, output, ivars):
    command = ["lldb", "-b", "-p", str(a.pid), "-o",
               "command script import " + shlex.quote(str(root / "tools/lldb/annotate.py")),
               "-o", "annotate " + shlex.join(map(str, [output, methods, ivars,
               runtime / "class-addresses.json", runtime / "method-addresses.json"])),
               "-o", "detach", "-o", "quit"]
    run = subprocess.run(command, check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if "Traceback" in run.stdout or not output.exists():
        raise RuntimeError(run.stdout)
    text = output.read_text()
    if "未找到" in text:
        raise RuntimeError("Missing exact symbol boundary: " + text)
    return text


with tempfile.TemporaryDirectory(prefix="statusbar-asm-") as folder:
    temp = pathlib.Path(folder)
    ivars = temp / "ivars.txt"
    ivars.write_text("")
    methods = root / f"tools/statusbar/methods{version.split('.')[0]}.txt"
    body = export(methods, temp / "methods.asm", ivars)
    if version == "27.0":
        names, labels = [], {}
        for section in body.split("\n### ")[1:]:
            title = section.splitlines()[0]
            if "WifiSignalIconView" not in title or not any(s in title for s in
                    ("_updateImage]", "_totalWidthFor:]", "_totalHeightFor:]", "_pointSizeFor:]")):
                continue
            targets = set(re.findall(r"^\+\d+\s+b(?:l)?\s+0x[0-9a-f]+\s+; (___lldb_unnamed_symbol_\w+)\s*$", section, re.M))
            if len(targets) != 1:
                raise RuntimeError("Unexpected thunk structure: " + title)
            name = targets.pop()
            names.append(name)
            labels[name] = title.split("  (")[0]
        if len(names) != 4:
            raise RuntimeError("Expected four verified Swift thunks")
        leaves = temp / "leaves.txt"
        leaves.write_text("\n".join(names) + "\n")
        leaf_body = export(leaves, temp / "leaves.asm", ivars)
        for name, label in labels.items():
            leaf_body = leaf_body.replace("### " + name, "### Swift implementation reached from " + label)
        body += "\n; Following exact branch targets from the thunks above.\n" + leaf_body
    header = f"; iOS {version} arm64 Simulator. ASLR addresses belong to this capture.\n"
    header += "; Reconstructed analysis input, not Apple source. No ambiguous ivar-name annotations.\n"
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(header + "\n".join(line.rstrip() for line in body.splitlines()) + "\n")
print(f"Exported iOS {version} methods to {a.output}")
