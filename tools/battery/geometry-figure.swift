import AppKit

// 从 pathprobe 导出的真实控制点画研究图，不重新拟合曲线。
// swift geometry-figure.swift <paths.json> <输出目录>
let args = CommandLine.arguments
guard args.count == 3 else { fatalError("geometry-figure <paths.json> <output-directory>") }
let json = try JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: args[1]))) as! [String: Any]
let output = URL(fileURLWithPath: args[2], isDirectory: true)
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
let ink = NSColor(srgbRed: 0.09, green: 0.14, blue: 0.22, alpha: 1)
let secondary = NSColor(srgbRed: 0.33, green: 0.39, blue: 0.46, alpha: 1)
let blue = NSColor(srgbRed: 0.05, green: 0.43, blue: 0.72, alpha: 1)
let orange = NSColor(srgbRed: 0.8, green: 0.33, blue: 0.05, alpha: 1)
let grid = NSColor(srgbRed: 0.72, green: 0.77, blue: 0.81, alpha: 1)
var height: CGFloat = 600
func pt(_ x: CGFloat, _ y: CGFloat) -> NSPoint { NSPoint(x: x, y: height-y) }
func text(_ s: String, _ x: CGFloat, _ y: CGFloat, size: CGFloat = 18, color: NSColor = ink) {
    (s as NSString).draw(at: pt(x, y+size*1.25), withAttributes: [.font: NSFont.systemFont(ofSize: size), .foregroundColor: color])
}
func line(_ x: CGFloat, _ y: CGFloat, _ x2: CGFloat, _ y2: CGFloat, color: NSColor = grid, dashed: Bool = false) {
    let p = NSBezierPath(); p.move(to: pt(x,y)); p.line(to: pt(x2,y2)); p.lineWidth=1.5
    if dashed { p.setLineDash([5,5],count:2,phase:0) }; color.setStroke(); p.stroke()
}
func box(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
    let p=NSBezierPath(rect:NSRect(x:x,y:height-y-h,width:w,height:h))
    p.setLineDash([5,5],count:2,phase:0); grid.setStroke(); p.stroke()
}
func path(_ name: String, x: CGFloat, y: CGFloat, scale: CGFloat) -> NSBezierPath {
    let p = NSBezierPath()
    let elements=(json[name] as! [String:Any])["elements"] as! [[String:Any]]
    for e in elements {
        let points=(e["points"] as! [[Double]]).map { pt(x+CGFloat($0[0])*scale,y+CGFloat($0[1])*scale) }
        switch e["op"] as! String {
        case "M":p.move(to:points[0])
        case "L":p.line(to:points[0])
        case "C":p.curve(to:points[2],controlPoint1:points[0],controlPoint2:points[1])
        case "Z":p.close()
        default:fatalError("unexpected path element")
        }
    }
    return p
}
func figure(_ name: String, _ draw: () -> Void) throws {
    let bitmap=NSBitmapImageRep(bitmapDataPlanes:nil,pixelsWide:1100,pixelsHigh:Int(height),bitsPerSample:8,samplesPerPixel:4,hasAlpha:true,isPlanar:false,colorSpaceName:.calibratedRGB,bytesPerRow:0,bitsPerPixel:0)!
    NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current=NSGraphicsContext(bitmapImageRep:bitmap)
    NSColor.white.setFill(); NSRect(x:0,y:0,width:1100,height:height).fill(); draw()
    NSGraphicsContext.restoreGraphicsState()
    try bitmap.representation(using:.png,properties:[:])!.write(to:output.appendingPathComponent(name))
}
try figure("battery-cap-geometry.png") {
    text("Cap / pin 的真实几何",32,22,size:28)
    text("iOS 17.4 · iconSize 8 · w = 1⅔ pt · h = 5 pt",32,66,color:secondary)
    text("圆与矩形的交集",48,114,size:22)
    let x:CGFloat=270,y:CGFloat=172,s:CGFloat=60,r:CGFloat=2.5,d:CGFloat=5/6
    let circle=NSBezierPath(ovalIn:NSRect(x:x+(-d-r)*s,y:height-y-5*s,width:5*s,height:5*s))
    blue.withAlphaComponent(0.05).setFill();circle.fill();blue.setStroke();circle.lineWidth=1.5;circle.stroke()
    box(x,y,5/3*s,5*s)
    let cap=path("pin-1.66666667x5.00000000-complex0",x:x,y:y,scale:s)
    blue.withAlphaComponent(0.3).setFill();cap.fill();blue.setStroke();cap.lineWidth=2;cap.stroke()
    line(x,y-12,x,y+5*s+12,color:ink,dashed:true)
    line(x-d*s,y+r*s,x+5/3*s,y+r*s,color:blue,dashed:true)
    NSBezierPath(ovalIn:NSRect(x:x-d*s-3,y:height-y-r*s-3,width:6,height:6)).fill()
    text("r = 2.5",x-20,y+r*s-30,size:16,color:blue)
    text("x = 0",x-20,y+5*s+20,size:16)
    text("圆心 (−0.8333, 2.5)",64,510,size:18)
    text("保留 x ≥ 0 的圆弧切片",64,544,size:18,color:secondary)
    line(485,114,485,565)
    text("两条实际代码分支",545,114,size:22)
    for (i,complex) in [0,1].enumerated() {
        let bx:CGFloat=CGFloat(590+i*260)
        box(bx,y,100,300)
        let p=path("pin-1.66666667x5.00000000-complex\(complex)",x:bx,y:y,scale:s)
        (complex==0 ? blue : orange).withAlphaComponent(0.22).setFill();p.fill()
        (complex==0 ? blue : orange).setStroke();p.lineWidth=2;p.stroke()
        text(complex==0 ? "状态栏：圆弧切片" : "complex：右侧双圆角",bx-40,510,size:18)
        text(complex==0 ? "可见高度 ≈ 4.714 pt" : "可见高度 = 5 pt",bx-40,544,size:17,color:secondary)
    }
}
try figure("battery-corner-geometry.png") {
    text("同一个 cornerRadius，不同的曲线",32,22,size:28)
    text("描边中心线 · 27⅙ × 13⅙ pt · radius ≈ 4.2133 pt",32,66,color:secondary)
    let x:CGFloat=170,y:CGFloat=125,s:CGFloat=25
    let p=path("rounded-body",x:x,y:y,scale:s)
    blue.withAlphaComponent(0.045).setFill();p.fill();blue.setStroke();p.lineWidth=3;p.stroke()
    let inset:CGFloat=7/12,w:CGFloat=163/6,h:CGFloat=79/6,r:CGFloat=h/3.125
    // 显式使用四段圆弧；不假设系统 roundedRect 便利构造器采用哪种曲线。
    let circular=CGMutablePath()
    circular.move(to:CGPoint(x:r,y:0)); circular.addLine(to:CGPoint(x:w-r,y:0))
    circular.addArc(center:CGPoint(x:w-r,y:r),radius:r,startAngle:-.pi/2,endAngle:0,clockwise:false)
    circular.addLine(to:CGPoint(x:w,y:h-r))
    circular.addArc(center:CGPoint(x:w-r,y:h-r),radius:r,startAngle:0,endAngle:.pi/2,clockwise:false)
    circular.addLine(to:CGPoint(x:r,y:h))
    circular.addArc(center:CGPoint(x:r,y:h-r),radius:r,startAngle:.pi/2,endAngle:.pi,clockwise:false)
    circular.addLine(to:CGPoint(x:0,y:r))
    circular.addArc(center:CGPoint(x:r,y:r),radius:r,startAngle:.pi,endAngle:3 * .pi/2,clockwise:false)
    circular.closeSubpath()
    let ctx=NSGraphicsContext.current!.cgContext
    ctx.saveGState();ctx.translateBy(x:x+inset*s,y:height-y-inset*s);ctx.scaleBy(x:s,y:-s)
    ctx.addPath(circular);ctx.setStrokeColor(orange.cgColor);ctx.setLineWidth(2/s);ctx.setLineDash(phase:0,lengths:[7/s,5/s]);ctx.strokePath();ctx.restoreGState()
    text("蓝实线：系统导出的路径，每角 3 段三次曲线",32,512,size:19,color:blue)
    text("橙虚线：普通圆弧圆角，名义 radius 相同",32,550,size:19,color:orange)
}
