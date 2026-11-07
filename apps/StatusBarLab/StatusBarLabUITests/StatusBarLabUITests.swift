import XCTest

/// 真实点击界面，核对 status-bar-overrides 域数据。
/// 设置 TEST_RUNNER_SBLAB_OUT 后会把每一步的截图写到该目录。
final class StatusBarLabUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.buttons["reset"].tap()
    }

    override func tearDown() {
        // 不把覆盖留在设备上
        app.buttons["reset"].tap()
    }

    private func button(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label CONTAINS %@", title)).firstMatch
    }

    private func tapPreset(_ title: String) {
        let target = button(title)
        var swipes = 0
        while !target.isHittable, swipes < 4 {
            app.scrollViews.firstMatch.swipeLeft()
            swipes += 1
        }
        target.tap()
    }

    private func domainText() -> String {
        let read = button("读取")
        var swipes = 0
        while !read.isHittable, swipes < 12 {
            app.swipeUp()
            swipes += 1
        }
        read.tap()
        Thread.sleep(forTimeInterval: 0.6)
        // 列表是懒加载的，文本行要滚进屏幕才存在
        app.swipeUp()
        let text = app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "STStatusBarOverridesStatusDomainData")).firstMatch
        let value = text.waitForExistence(timeout: 3) ? text.label : ""
        for _ in 0..<(swipes + 3) { app.swipeDown() }
        return value
    }

    private func checkpoint(_ name: String) {
        Thread.sleep(forTimeInterval: 1.5)
        guard let dir = ProcessInfo.processInfo.environment["SBLAB_OUT"] else { return }
        try? XCUIScreen.main.screenshot().pngRepresentation
            .write(to: URL(fileURLWithPath: dir).appendingPathComponent(name + ".png"))
    }

    func testPresetsChangeStatusBar() {
        tapPreset("截图用")
        checkpoint("1-screenshot-preset")
        var domain = domainText()
        XCTAssertTrue(domain.contains("stringValue: 9:41"), domain)
        XCTAssertTrue(domain.contains("capacity: 100"), domain)

        tapPreset("低电量")
        checkpoint("2-low-battery")
        domain = domainText()
        XCTAssertTrue(domain.contains("capacity: 15"), domain)
        XCTAssertTrue(domain.contains("saverModeActive: NO"), domain)

        tapPreset("省电模式")
        checkpoint("3-low-power-mode")
        domain = domainText()
        XCTAssertTrue(domain.contains("capacity: 18"), domain)
        XCTAssertTrue(domain.contains("saverModeActive: YES"), domain)

        tapPreset("充电中")
        checkpoint("4-charging")
        domain = domainText()
        XCTAssertTrue(domain.contains("state: charging"), domain)

        tapPreset("无信号")
        checkpoint("5-no-signal")
        domain = domainText()
        XCTAssertTrue(domain.contains("status: searching"), domain)
        XCTAssertTrue(domain.contains("type: none"), domain)

        app.buttons["reset"].tap()
        checkpoint("6-reset")
        domain = domainText()
        XCTAssertFalse(domain.contains("mainBatteryEntry"), domain)
        XCTAssertFalse(domain.contains("timeEntry"), domain)
    }
}
