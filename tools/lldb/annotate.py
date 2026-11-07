"""lldb 脚本：反汇编 ObjC 方法，并解析 adrp 引用的常量和实例变量名。

用法：lldb -b -p <pid> -o 'command script import tools/lldb/annotate.py' \
          -o 'annotate <输出文件> <方法列表文件> <实例变量偏移表>' -o detach
"""
import re
import struct
import lldb


def ivar_table(path):
    """读取 simprobe 导出的偏移表，每行：<偏移> <名称>。"""
    table = {}
    for line in open(path):
        offset, name = line.split()[:2]
        table.setdefault(int(offset), []).append(name)
    return table


def read_double(process, addr):
    err = lldb.SBError()
    data = process.ReadMemory(addr, 8, err)
    return struct.unpack("<d", data)[0] if err.Success() else None


def read_int32(process, addr):
    err = lldb.SBError()
    data = process.ReadMemory(addr, 4, err)
    return struct.unpack("<i", data)[0] if err.Success() else None


def describe(target, process, addr):
    """尝试把地址解释成 NSString 或符号。"""
    sb = target.ResolveLoadAddress(addr)
    symbol = sb.GetSymbol()
    if symbol.IsValid() and symbol.GetName():
        return symbol.GetName()
    err = lldb.SBError()
    # __NSConstantString：isa, flags, cstr, length
    ptr = process.ReadPointerFromMemory(addr + 16, err)
    if err.Success() and ptr:
        text = process.ReadCStringFromMemory(ptr, 200, err)
        if err.Success() and text and text.isprintable():
            return f'@"{text}"'
    return None


def annotate(debugger, command, result, internal):
    out_path, list_path, ivar_path = command.split()
    target = debugger.GetSelectedTarget()
    process = target.GetProcess()
    names = [l.strip() for l in open(list_path) if l.strip() and not l.startswith("#")]
    ivars = ivar_table(ivar_path)
    with open(out_path, "w") as out:
        out.write(f"ivars: {len(ivars)}\n")
        for name in names:
            found = target.FindFunctions(name) if False else target.FindSymbols(name)
            if found.GetSize() == 0:
                out.write(f"\n### {name}: 未找到\n")
                continue
            sym = found.GetContextAtIndex(0).GetSymbol()
            insts = sym.GetInstructions(target)
            out.write(f"\n### {name}  ({insts.GetSize()} 条)\n")
            pages = {}
            start = sym.GetStartAddress().GetLoadAddress(target)
            for i in range(insts.GetSize()):
                inst = insts.GetInstructionAtIndex(i)
                pc = inst.GetAddress().GetLoadAddress(target)
                mnem = inst.GetMnemonic(target)
                ops = inst.GetOperands(target)
                note = inst.GetComment(target) or ""
                m = re.match(r"(x\d+), (-?\d+)$", ops) if mnem == "adrp" else None
                if m:
                    pages[m.group(1)] = (pc & ~0xfff) + (int(m.group(2)) << 12)
                m = re.match(r"(d\d+), \[(x\d+), #(0x[0-9a-f]+)\]", ops) if mnem == "ldr" else None
                if m and m.group(2) in pages:
                    value = read_double(process, pages[m.group(2)] + int(m.group(3), 16))
                    # 低位数据也可能是 block flags，只标注看起来像常量的值
                    if value is not None and (value == 0 or 1e-6 < abs(value) < 1e6):
                        note = f"= {value}"
                m = re.match(r"(x\d+), \[(x\d+), #(0x[0-9a-f]+)\]", ops) if mnem == "ldrsw" else None
                if m and m.group(2) in pages:
                    value = read_int32(process, pages[m.group(2)] + int(m.group(3), 16))
                    note = "ivar " + "/".join(ivars.get(value, [str(value)]))
                m = re.match(r"(x\d+), (x\d+), #(0x[0-9a-f]+)", ops) if mnem == "add" else None
                if m and m.group(2) in pages:
                    text = describe(target, process, pages[m.group(2)] + int(m.group(3), 16))
                    if text:
                        note = text
                out.write(f"+{pc - start:<5d}{mnem:8s}{ops:42s}{(' ; ' + note) if note else ''}\n")
    result.AppendMessage(f"写入 {out_path}")


def __lldb_init_module(debugger, internal):
    debugger.HandleCommand(f"command script add -f {__name__}.annotate annotate")
