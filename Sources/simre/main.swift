import Foundation

func usage() -> Never {
    print("""
    用法:
      simre list
      simre boot|shutdown|state <设备>
      simre statusbar <设备> time <文本>
      simre statusbar <设备> network <类型>
      simre statusbar <设备> wifi <模式> <格数>
      simre statusbar <设备> cellular <模式> <运营商> <格数>
      simre statusbar <设备> battery <状态> <电量> [not-charging]
      simre statusbar <设备> clear
    """)
    exit(2)
}

// CoreSimulator 的状态通过 XPC 通知更新，需要运行 RunLoop 才能收到。
func wait(_ label: String, since start: Date, timeout: TimeInterval, until done: () -> Bool) throws {
    while !done() {
        guard Date().timeIntervalSince(start) < timeout else {
            throw SimError.failed("等待 \(label) 超时")
        }
        RunLoop.current.run(until: Date().addingTimeInterval(0.2))
    }
    print(String(format: "%@：%.1fs", label, Date().timeIntervalSince(start)))
}

let args = Array(CommandLine.arguments.dropFirst())
guard let command = args.first else { usage() }

do {
    let sim = try CoreSim()
    switch (command, args.count) {
    case ("list", 1):
        for d in sim.devices().sorted(by: { ($0.runtime, $0.name) < ($1.runtime, $1.name) }) {
            let row = [d.state.padding(toLength: 10, withPad: " ", startingAt: 0),
                       d.udid, d.runtime, d.name]
            print(row.joined(separator: "  "))
        }
    case ("state", 2):
        print(try sim.device(args[1]).state)
    case ("statusbar", 3...):
        let d = try sim.device(args[1])
        let rest = Array(args.dropFirst(3))
        func n(_ i: Int) throws -> UInt64 {
            guard i < rest.count, let v = UInt64(rest[i]) else { usage() }
            return v
        }
        switch args[2] {
        case "time" where rest.count == 1: try d.statusBarTime(rest[0])
        case "network": try d.statusBarNetwork(try n(0))
        case "wifi": try d.statusBarWiFi(mode: try n(0), bars: try n(1))
        case "cellular" where rest.count == 3:
            try d.statusBarCellular(mode: try n(0), carrier: rest[1], bars: try n(2))
        case "battery": try d.statusBarBattery(state: try n(0), level: try n(1), notCharging: rest.count > 2 && rest[2] == "not-charging")
        case "clear": try d.statusBarClear()
        default: usage()
        }
        print("ok")
    case ("boot", 2):
        let d = try sim.device(args[1])
        print("启动 \(d.name) (\(d.udid))，当前 \(d.state)")
        let start = Date()
        try d.boot()
        print(String(format: "boot 调用返回：%.1fs", Date().timeIntervalSince(start)))
        try wait("state=Booted", since: start, timeout: 180) { d.state == "Booted" }
        var last = ""
        // 只代表系统应用已启动。实测此后画面还要 6-9s 才到桌面，详见 notes。
        try wait("系统应用已启动", since: start, timeout: 300) {
            let now = d.bootStatusDump
            if now != last {
                print(String(format: "  %.1fs %@", Date().timeIntervalSince(start), now))
                last = now
            }
            return d.bootFinished
        }
    case ("shutdown", 2):
        let d = try sim.device(args[1])
        let start = Date()
        try d.shutdown()
        try wait("state=Shutdown", since: start, timeout: 60) { d.state == "Shutdown" }
    default:
        usage()
    }
} catch {
    FileHandle.standardError.write(Data("错误: \(error)\n".utf8))
    exit(1)
}
