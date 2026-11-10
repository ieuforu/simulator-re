import AppKit
// compare <截屏> <重绘png> <px> <py> <输出三联图>：重绘图合成到截屏背景色上，与截屏同位置逐像素比较
let a = CommandLine.arguments
func load(_ p: String) -> NSBitmapImageRep {
    let r = NSBitmapImageRep(data: try! Data(contentsOf: URL(fileURLWithPath: p)))!
    // 统一转成 sRGB 8 位 RGBA
    let out = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: r.pixelsWide, pixelsHigh: r.pixelsHigh, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)!.retagging(with: .sRGB)!
    NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: out)
    NSGraphicsContext.current!.compositingOperation = .copy
    r.draw(in: NSRect(x: 0, y: 0, width: r.pixelsWide, height: r.pixelsHigh))
    NSGraphicsContext.restoreGraphicsState(); return out
}
func px(_ r: NSBitmapImageRep, _ x: Int, _ y: Int) -> [Double] {
    let p = r.bitmapData! + y * r.bytesPerRow + x * 4; return (0..<4).map { Double(p[$0]) }
}
let shot = load(a[1]), mine = load(a[2]); let X = Int(a[3])!, Y = Int(a[4])!
let w = mine.pixelsWide, h = mine.pixelsHigh
let bg = px(shot, X + w / 2, Y - 9)   // 电池上方 3pt 处的背景色
var sum = 0.0, maxd = 0.0, big = 0, n = 0
let S = 10, W3 = w * S * 3 + 40
let out = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W3, pixelsHigh: h * S, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)!
func put(_ x: Int, _ y: Int, _ c: [Double]) { for dy in 0..<S { for dx in 0..<S { let p = out.bitmapData! + (y * S + dy) * out.bytesPerRow + (x * S + dx) * 4; for k in 0..<3 { p[k] = UInt8(max(0, min(255, c[k]))) }; p[3] = 255 } } }
for y in 0..<h { for x in 0..<w {
    let s = px(shot, X + x, Y + y), m = px(mine, x, y)
    let al = m[3] / 255
    let c = (0..<3).map { m[$0] + bg[$0] * (1 - al) }   // 预乘 alpha 合成
    let d = (0..<3).map { abs(c[$0] - s[$0]) }.max()!
    sum += d; n += 1; maxd = max(maxd, d); if d > 32 { big += 1 }
    put(x, y, s); put(x + w + 2, y, c)
    put(x + 2 * w + 4, y, d > 32 ? [255, 0, 0] : [255 - d * 4, 255 - d * 4, 255 - d * 4])
} }
for y in 0..<(h * S) { for x in [w * S, w * S + 1, (2 * w + 2) * S, (2 * w + 2) * S + 1] { let p = out.bitmapData! + y * out.bytesPerRow + x * 4; p[0] = 120; p[1] = 120; p[2] = 255; p[3] = 255 } }
try! out.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: a[5]))
print(String(format: "平均差 %.2f  最大差 %.0f  差>32 的像素 %d/%d (%.2f%%)", sum / Double(n), maxd, big, n, 100 * Double(big) / Double(n)))
