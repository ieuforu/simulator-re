import Foundation

// 不链接私有框架：运行时 dlopen，再通过 ObjC 运行时调用。
enum SimError: Error, CustomStringConvertible {
    case load(String), missing(String), failed(String)
    var description: String {
        switch self {
        case .load(let s): return "加载失败: \(s)"
        case .missing(let s): return "找不到: \(s)"
        case .failed(let s): return s
        }
    }
}

private let frameworkPath =
    "/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator"

// objc_msgSend 在 Swift 里不可用，取出函数指针后按每个方法的真实签名强转。
private let msgSend: UnsafeMutableRawPointer = dlsym(
    UnsafeMutableRawPointer(bitPattern: -2), "objc_msgSend")!  // RTLD_DEFAULT

private typealias IdIdErr = @convention(c) (
    AnyObject, Selector, AnyObject, UnsafeMutablePointer<NSError?>
) -> AnyObject?
private typealias IdErr = @convention(c) (
    AnyObject, Selector, UnsafeMutablePointer<NSError?>
) -> AnyObject?
private typealias BoolIdErr = @convention(c) (
    AnyObject, Selector, AnyObject, UnsafeMutablePointer<NSError?>
) -> Bool
private typealias BoolErr = @convention(c) (
    AnyObject, Selector, UnsafeMutablePointer<NSError?>
) -> Bool

private func developerDir() throws -> String {
    if let d = ProcessInfo.processInfo.environment["DEVELOPER_DIR"], !d.isEmpty { return d }
    let p = Process()
    let out = Pipe()
    p.executableURL = URL(fileURLWithPath: "/usr/bin/xcode-select")
    p.arguments = ["-p"]
    p.standardOutput = out
    try p.run()
    p.waitUntilExit()
    let data = out.fileHandleForReading.readDataToEndOfFile()
    guard let s = String(data: data, encoding: .utf8)?
        .trimmingCharacters(in: .whitespacesAndNewlines), !s.isEmpty
    else { throw SimError.missing("Xcode 开发者目录") }
    return s
}

struct Device {
    let object: NSObject

    private func check(_ ok: Bool, _ err: NSError?, _ what: String) throws {
        guard ok else { throw SimError.failed("\(what)失败: \(err?.localizedDescription ?? "未知错误")") }
    }

    func statusBarTime(_ text: String) throws {
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: BoolIdErr.self)
        let ok = f(object, NSSelectorFromString("overrideStatusBarTimeString:error:"), text as NSString, &err)
        try check(ok, err, "设置时间")
    }

    func statusBarNetwork(_ type: UInt64) throws {
        typealias F = @convention(c) (AnyObject, Selector, UInt64, UnsafeMutablePointer<NSError?>) -> Bool
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: F.self)
        let ok = f(object, NSSelectorFromString("overrideStatusBarDataNetworkType:error:"), type, &err)
        try check(ok, err, "设置网络类型")
    }

    func statusBarWiFi(mode: UInt64, bars: UInt64) throws {
        typealias F = @convention(c) (AnyObject, Selector, UInt64, UInt64, UnsafeMutablePointer<NSError?>) -> Bool
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: F.self)
        let ok = f(object, NSSelectorFromString("overrideStatusBarWiFiMode:bars:error:"), mode, bars, &err)
        try check(ok, err, "设置 Wi-Fi")
    }

    func statusBarCellular(mode: UInt64, carrier: String, bars: UInt64) throws {
        typealias F = @convention(c) (AnyObject, Selector, UInt64, AnyObject, UInt64, UnsafeMutablePointer<NSError?>) -> Bool
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: F.self)
        let ok = f(object, NSSelectorFromString("overrideStatusBarCellularMode:operatorName:bars:error:"),
                   mode, carrier as NSString, bars, &err)
        try check(ok, err, "设置蜂窝网络")
    }

    func statusBarBattery(state: UInt64, level: UInt64, notCharging: Bool = false) throws {
        typealias F = @convention(c) (AnyObject, Selector, UInt64, UInt64, Bool, UnsafeMutablePointer<NSError?>) -> Bool
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: F.self)
        let ok = f(object, NSSelectorFromString("overrideStatusBarBatteryState:batteryLevel:showNotCharging:error:"),
                   state, level, notCharging, &err)
        try check(ok, err, "设置电池")
    }

    func statusBarClear() throws {
        typealias F = @convention(c) (AnyObject, Selector, UInt64, UnsafeMutablePointer<NSError?>) -> Bool
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: F.self)
        let ok = f(object, NSSelectorFromString("clearStatusBarOverrides:error:"), UInt64.max, &err)
        try check(ok, err, "清除覆盖")
    }

    var name: String { object.value(forKey: "name") as? String ?? "?" }
    var udid: String { (object.value(forKey: "UDID") as? NSUUID)?.uuidString ?? "?" }
    var state: String { object.value(forKey: "stateString") as? String ?? "?" }
    var runtime: String {
        (object.value(forKey: "runtime") as? NSObject)?.value(forKey: "name") as? String ?? "?"
    }

    /// 系统应用是否已启动，不代表桌面已显示。
    /// 只在发起启动的进程里持续监听才可靠：新进程读到的是缓存的终态。
    var bootFinished: Bool {
        guard let info = object.value(forKey: "bootStatus") as? NSObject else { return false }
        return info.value(forKey: "isTerminalStatus") as? Bool ?? false
    }

    /// bootStatus 的原始字段，用于打印启动阶段的跳变
    var bootStatusDump: String {
        guard let info = object.value(forKey: "bootStatus") as? NSObject else { return "nil" }
        let status = info.value(forKey: "status") ?? "?"
        let terminal = info.value(forKey: "isTerminalStatus") ?? "?"
        let elapsed = info.value(forKey: "bootElapsedTime") ?? "?"
        return "status=\(status) terminal=\(terminal) elapsed=\(elapsed)"
    }

    func boot() throws {
        // persist=true：设备不随本进程退出而关闭
        let options: NSDictionary = ["persist": true]
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: BoolIdErr.self)
        guard f(object, NSSelectorFromString("bootWithOptions:error:"), options, &err) else {
            throw SimError.failed("启动失败: \(err?.localizedDescription ?? "未知错误")")
        }
    }

    func shutdown() throws {
        var err: NSError?
        let f = unsafeBitCast(msgSend, to: BoolErr.self)
        guard f(object, NSSelectorFromString("shutdownWithError:"), &err) else {
            throw SimError.failed("关闭失败: \(err?.localizedDescription ?? "未知错误")")
        }
    }
}

final class CoreSim {
    private let deviceSet: NSObject

    init() throws {
        guard dlopen(frameworkPath, RTLD_NOW) != nil else {
            throw SimError.load(String(cString: dlerror()))
        }
        guard let contextClass = NSClassFromString("SimServiceContext") else {
            throw SimError.missing("SimServiceContext")
        }

        var err: NSError?
        let shared = unsafeBitCast(msgSend, to: IdIdErr.self)
        guard let context = shared(
            contextClass,
            NSSelectorFromString("sharedServiceContextForDeveloperDir:error:"),
            try developerDir() as NSString,
            &err)
        else { throw SimError.failed("连接服务失败: \(err?.localizedDescription ?? "未知错误")") }

        let getSet = unsafeBitCast(msgSend, to: IdErr.self)
        guard let set = getSet(context, NSSelectorFromString("defaultDeviceSetWithError:"), &err)
            as? NSObject
        else { throw SimError.failed("读取设备集失败: \(err?.localizedDescription ?? "未知错误")") }
        deviceSet = set
    }

    func devices() -> [Device] {
        (deviceSet.value(forKey: "availableDevices") as? [NSObject] ?? []).map(Device.init)
    }

    func device(_ query: String) throws -> Device {
        let found = devices().filter { $0.udid == query.uppercased() || $0.name == query }
        guard let first = found.first else { throw SimError.missing("设备 \(query)") }
        guard found.count == 1 else { throw SimError.failed("名称不唯一，请用 UDID: \(query)") }
        return first
    }
}
