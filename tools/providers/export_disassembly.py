#!/usr/bin/env python3
"""Export relevant native methods and labelled excerpts of region initialization."""
import argparse
import pathlib
import re
import shlex
import subprocess
import tempfile

p = argparse.ArgumentParser()
p.add_argument("pid", type=int, help="waiting signalprobe process in the same runtime")
p.add_argument("class_map", type=pathlib.Path, help="providerprobe's class-addresses.json from the same runtime")
p.add_argument("output", type=pathlib.Path)
a = p.parse_args()
root = pathlib.Path(__file__).resolve().parents[2]
with tempfile.TemporaryDirectory(prefix="provider-disassembly-") as temp:
    temp = pathlib.Path(temp)
    ivars = temp / "ivars.txt"
    ivars.write_text("")  # Avoid ambiguous cross-class offset/name annotations.
    setup = temp / "setup-methods.txt"
    setup.write_text("-[STUIStatusBarVisualProvider_DynamicSplit setupInContainerView:]\n"
                     "-[STUIStatusBarVisualProvider_FixedSplit setupInContainerView:]\n")
    commands = ["command script import " + shlex.quote(str(root / "tools/lldb/annotate.py"))]
    for dest, methods in [(temp / "full.asm", root / "tools/providers/methods.txt"), (temp / "setup.asm", setup)]:
        commands.append("annotate " + shlex.join(map(str, [dest, methods, ivars, a.class_map.resolve()])))
    commands += ["detach", "quit"]
    command = ["lldb", "-b", "-p", str(a.pid)]
    for c in commands:
        command += ["-o", c]
    result = subprocess.run(command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=True)
    if "Traceback" in result.stdout:
        raise RuntimeError(result.stdout)
    body = (temp / "full.asm").read_text()
    if "未找到" in body:
        raise RuntimeError("A requested symbol was not found; inspect the method list")
    for part in (temp / "setup.asm").read_text().split("\n### ")[1:]:
        title, *lines = part.splitlines()
        lower, upper = (1844, 2236) if "DynamicSplit" in title else (3068, 3312)
        body += f"\n### EXCERPT: {title}; offsets +{lower}..+{upper}, trailing-region setup only\n"
        for line in lines:
            m = re.match(r"\+(\d+)\s", line)
            if m and lower <= int(m[1]) <= upper:
                body += line + "\n"
    text = "; iOS 17.4 (21E213) arm64 Simulator; 2026-11-17\n"
    text += "; Native disassembly with runtime class references. Addresses are session-specific.\n"
    text += "; Setup methods are explicitly excerpted; ivar offsets are kept numeric.\n"
    text += "\n".join(line.rstrip() for line in body.splitlines()) + "\n"
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(text)
    print(f"Exported {len(text.splitlines())} lines to {a.output}")
