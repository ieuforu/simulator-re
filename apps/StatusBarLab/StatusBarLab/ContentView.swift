import SwiftUI

struct ContentView: View {
    @State private var overrides = Overrides()
    @State private var bridge = StatusBarBridge()
    @State private var domainText = ""

    var body: some View {
        NavigationStack {
            Form {
                if !bridge.available {
                    Section {
                        Label("SystemStatus 不可用，这个 App 只能在模拟器里运行。", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.red)
                    }
                }
                presetSection
                timeSection
                batterySection
                wifiSection
                cellularSection
                domainSection
            }
            .navigationTitle("状态栏实验室")
            .toolbar {
                Button("恢复默认", role: .destructive) { overrides = Overrides() }
                    .accessibilityIdentifier("reset")
            }
        }
        .onChange(of: overrides) {
            bridge.publishEntries(overrides.entries)
            refreshDomain()
        }
    }

    private var presetSection: some View {
        Section("快捷预设") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    preset("截图用", "camera") {
                        $0.timeEnabled = true
                        $0.time = "9:41"
                        $0.batteryEnabled = true
                        $0.batteryLevel = 100
                        $0.batteryState = .draining
                        $0.lowPowerMode = false
                        $0.wifiEnabled = true
                        $0.wifiHidden = false
                        $0.wifiBars = 3
                        $0.wifiStatus = .connected
                        $0.cellularEnabled = true
                        $0.cellularHidden = false
                        $0.cellularBars = 4
                        $0.cellularStatus = .connected
                    }
                    preset("低电量", "battery.25") {
                        $0.batteryEnabled = true
                        $0.batteryLevel = 15
                        $0.batteryState = .draining
                        $0.lowPowerMode = false
                    }
                    preset("省电模式", "bolt.circle") {
                        $0.batteryEnabled = true
                        $0.batteryLevel = 18
                        $0.batteryState = .draining
                        $0.lowPowerMode = true
                    }
                    preset("充电中", "battery.100.bolt") {
                        $0.batteryEnabled = true
                        $0.batteryLevel = 42
                        $0.batteryState = .charging
                        $0.lowPowerMode = false
                    }
                    preset("无信号", "wifi.slash") {
                        $0.wifiEnabled = true
                        $0.wifiHidden = true
                        $0.cellularEnabled = true
                        $0.cellularHidden = false
                        $0.cellularBars = 0
                        $0.cellularStatus = .searching
                        $0.cellularType = .none
                    }
                }
            }
        }
    }

    private func preset(_ title: String, _ icon: String, apply: @escaping (inout Overrides) -> Void) -> some View {
        Button {
            apply(&overrides)
        } label: {
            Label(title, systemImage: icon)
        }
        .buttonStyle(.bordered)
    }

    private var timeSection: some View {
        Section {
            Toggle("覆盖时间", isOn: $overrides.timeEnabled)
            if overrides.timeEnabled {
                TextField("时间", text: $overrides.time)
                    .keyboardType(.numbersAndPunctuation)
                    .autocorrectionDisabled()
            }
        } header: {
            Text("时间")
        }
    }

    private var batterySection: some View {
        Section("电池") {
            Toggle("覆盖电池", isOn: $overrides.batteryEnabled)
            if overrides.batteryEnabled {
                VStack(alignment: .leading) {
                    Text("电量 \(Int(overrides.batteryLevel))%")
                    Slider(value: $overrides.batteryLevel, in: 0...100, step: 1)
                }
                Picker("状态", selection: $overrides.batteryState) {
                    ForEach(BatteryState.allCases) { Text($0.title).tag($0) }
                }
                Toggle("低电量模式", isOn: $overrides.lowPowerMode)
                Toggle("电池内显示百分比", isOn: $overrides.showPercent)
            }
        }
    }

    private var wifiSection: some View {
        Section("Wi-Fi") {
            Toggle("覆盖 Wi-Fi", isOn: $overrides.wifiEnabled)
            if overrides.wifiEnabled {
                Toggle("隐藏图标", isOn: $overrides.wifiHidden)
                if !overrides.wifiHidden {
                    Picker("信号", selection: $overrides.wifiBars) {
                        ForEach(0...3, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .pickerStyle(.segmented)
                    Picker("状态", selection: $overrides.wifiStatus) {
                        ForEach(NetworkStatus.allCases) { Text($0.title).tag($0) }
                    }
                    Picker("类型", selection: $overrides.wifiType) {
                        ForEach(WifiType.allCases) { Text($0.title).tag($0) }
                    }
                }
            }
        }
    }

    private var cellularSection: some View {
        Section("蜂窝网络") {
            Toggle("覆盖蜂窝网络", isOn: $overrides.cellularEnabled)
            if overrides.cellularEnabled {
                Toggle("隐藏图标", isOn: $overrides.cellularHidden)
                if !overrides.cellularHidden {
                    Picker("信号", selection: $overrides.cellularBars) {
                        ForEach(0...4, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .pickerStyle(.segmented)
                    Picker("状态", selection: $overrides.cellularStatus) {
                        ForEach(NetworkStatus.allCases) { Text($0.title).tag($0) }
                    }
                    Picker("网络类型", selection: $overrides.cellularType) {
                        ForEach(CellularType.allCases) { Text($0.title).tag($0) }
                    }
                    TextField("运营商", text: $overrides.carrier)
                        .autocorrectionDisabled()
                }
            }
        }
    }

    private var domainSection: some View {
        Section("域数据（status-bar-overrides）") {
            Button("读取", action: refreshDomain)
            if !domainText.isEmpty {
                Text(domainText)
                    .font(.system(.caption2, design: .monospaced))
                    .textSelection(.enabled)
            }
        }
    }

    private func refreshDomain() {
        // 发布是异步的，稍等后再读回。
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            domainText = bridge.currentDomainDescription()
        }
    }
}
