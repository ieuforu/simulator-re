import Foundation

// 枚举值都是用 SystemStatus 自身的 description 校准出来的，见 notes/02-status-bar.md。
enum BatteryState: Int, CaseIterable, Identifiable {
    case draining = 0, charging, charged, notCharging, chargingImpossible
    var id: Int { rawValue }
    var title: String {
        switch self {
        case .draining: "放电"
        case .charging: "充电"
        case .charged: "已充满"
        case .notCharging: "未充电"
        case .chargingImpossible: "无法充电"
        }
    }
}

enum NetworkStatus: Int, CaseIterable, Identifiable {
    case disconnected = 2, searching = 3, connected = 5
    var id: Int { rawValue }
    var title: String {
        switch self {
        case .disconnected: "未连接"
        case .searching: "搜索中"
        case .connected: "已连接"
        }
    }
}

enum WifiType: Int, CaseIterable, Identifiable {
    case regular = 0, hotspot, ethernet
    var id: Int { rawValue }
    var title: String {
        switch self {
        case .regular: "Wi-Fi"
        case .hotspot: "热点"
        case .ethernet: "以太网"
        }
    }
}

enum CellularType: Int, CaseIterable, Identifiable {
    case none = 0, umts = 4, fourG = 5, lte = 6, lteA = 8, ltePlus = 9
    case fiveG = 10, fiveGPlus = 11, fiveGUWB = 12, fiveGUC = 13, satellite = 14, fiveGA = 15
    var id: Int { rawValue }
    var title: String {
        switch self {
        case .none: "不显示"
        case .umts: "3G"
        case .fourG: "4G"
        case .lte: "LTE"
        case .lteA: "LTE-A"
        case .ltePlus: "LTE+"
        case .fiveG: "5G"
        case .fiveGPlus: "5G+"
        case .fiveGUWB: "5G UW"
        case .fiveGUC: "5G UC"
        case .satellite: "卫星"
        case .fiveGA: "5G-A"
        }
    }
}

struct Overrides: Equatable {
    var timeEnabled = false
    var time = "9:41"

    var batteryEnabled = false
    var batteryLevel = 100.0
    var batteryState = BatteryState.draining
    var lowPowerMode = false
    var showPercent = false

    var wifiEnabled = false
    var wifiHidden = false
    var wifiBars = 3
    var wifiStatus = NetworkStatus.connected
    var wifiType = WifiType.regular

    var cellularEnabled = false
    var cellularHidden = false
    var cellularBars = 4
    var cellularStatus = NetworkStatus.connected
    var cellularType = CellularType.fiveG
    var carrier = "Carrier"

    /// 没开启的项不写入，发布后就等于移除了它的覆盖。
    var entries: [String: Any] {
        var result: [String: Any] = [:]
        if timeEnabled, let entry = StatusBarBridge.timeEntry(time) {
            result["timeEntry"] = entry
            result["shortTimeEntry"] = entry
        }
        if batteryEnabled {
            result["mainBatteryEntry"] = StatusBarBridge.batteryEntry(
                withCapacity: Int(batteryLevel),
                state: batteryState.rawValue,
                saverMode: lowPowerMode,
                showPercent: showPercent)
        }
        if wifiEnabled {
            result["wifiEntry"] = wifiHidden
                ? StatusBarBridge.hiddenWifiEntry()
                : StatusBarBridge.wifiEntry(
                    withType: wifiType.rawValue, status: wifiStatus.rawValue, bars: wifiBars)
        }
        if cellularEnabled {
            result["cellularEntry"] = cellularHidden
                ? StatusBarBridge.hiddenCellularEntry()
                : StatusBarBridge.cellularEntry(
                    withType: cellularType.rawValue, status: cellularStatus.rawValue,
                    bars: cellularBars, carrier: carrier)
        }
        return result
    }
}

enum Preset: CaseIterable, Identifiable {
    case screenshot, lowBattery, lowPowerMode, charging, noSignal
    var id: Self { self }

    var title: String {
        switch self {
        case .screenshot: "截图用"
        case .lowBattery: "低电量"
        case .lowPowerMode: "省电模式"
        case .charging: "充电中"
        case .noSignal: "无信号"
        }
    }

    var icon: String {
        switch self {
        case .screenshot: "camera"
        case .lowBattery: "battery.25"
        case .lowPowerMode: "bolt.circle"
        case .charging: "battery.100.bolt"
        case .noSignal: "wifi.slash"
        }
    }

    func apply(to o: inout Overrides) {
        switch self {
        case .screenshot:
            o.timeEnabled = true
            o.time = "9:41"
            o.batteryEnabled = true
            o.batteryLevel = 100
            o.batteryState = .draining
            o.lowPowerMode = false
            o.wifiEnabled = true
            o.wifiHidden = false
            o.wifiBars = 3
            o.wifiStatus = .connected
            o.cellularEnabled = true
            o.cellularHidden = false
            o.cellularBars = 4
            o.cellularStatus = .connected
        case .lowBattery:
            o.batteryEnabled = true
            o.batteryLevel = 15
            o.batteryState = .draining
            o.lowPowerMode = false
        case .lowPowerMode:
            o.batteryEnabled = true
            o.batteryLevel = 18
            o.batteryState = .draining
            o.lowPowerMode = true
        case .charging:
            o.batteryEnabled = true
            o.batteryLevel = 42
            o.batteryState = .charging
            o.lowPowerMode = false
        case .noSignal:
            o.wifiEnabled = true
            o.wifiHidden = true
            o.cellularEnabled = true
            o.cellularHidden = false
            o.cellularBars = 0
            o.cellularStatus = .searching
            o.cellularType = .none
        }
    }
}
