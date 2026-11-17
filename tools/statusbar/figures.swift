import AppKit

// Measurement figures from accepted simulator screenshots and Sketch metadata.
// This does not render a complete Sketch document or fit its flattened paths.
let args = CommandLine.arguments
guard args.count == 3 else { fatalError("figures <capture-directory> <output-directory>") }
let input = URL(fileURLWithPath: args[1]), output = URL(fileURLWithPath: args[2])
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
let ink = NSColor(srgbRed: 0.08, green: 0.13, blue: 0.2, alpha: 1)
let gray = NSColor(srgbRed: 0.36, green: 0.4, blue: 0.46, alpha: 1)
let blue = NSColor(srgbRed: 0.05, green: 0.43, blue: 0.75, alpha: 1)
var height: CGFloat = 880
func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> NSRect { NSRect(x:x,y:height-y-h,width:w,height:h) }
func label(_ s: String, _ x: CGFloat, _ y: CGFloat, _ size: CGFloat = 18, _ color: NSColor = ink) {
    (s as NSString).draw(at:NSPoint(x:x,y:height-y-size*1.3),withAttributes:[.font:NSFont.systemFont(ofSize:size),.foregroundColor:color])
}
func line(_ x: CGFloat,_ y: CGFloat,_ x2: CGFloat,_ y2: CGFloat) {
    let p=NSBezierPath();p.move(to:NSPoint(x:x,y:height-y));p.line(to:NSPoint(x:x2,y:height-y2));gray.withAlphaComponent(0.25).setStroke();p.stroke()
}
func read(_ version:String,_ tag:String) throws -> [String:Any] {
    try JSONSerialization.jsonObject(with:Data(contentsOf:input.appendingPathComponent("\(version)/\(tag).json"))) as! [String:Any]
}
func visibleIcons(_ d:[String:Any]) -> [[String:Any]] {
    (d["icons"] as! [[String:Any]]).filter { !($0["hiddenInHierarchy"] as! Bool) && ($0["alphaInHierarchy"] as! Double)>0.01 }
}
func crop(_ version:String,_ tag:String,_ area:CGRect,_ x:CGFloat,_ y:CGFloat,_ magnification:CGFloat) {
    let source=NSImage(contentsOf:input.appendingPathComponent("\(version)/\(tag)-screen.png"))!
    let full=source.cgImage(forProposedRect:nil,context:nil,hints:nil)!
    let pixels=CGRect(x:floor(area.minX*3),y:floor(area.minY*3),width:ceil(area.width*3),height:ceil(area.height*3))
    let part=full.cropping(to:pixels)!
    NSGraphicsContext.current!.imageInterpolation = .none
    NSImage(cgImage:part,size:NSSize(width:part.width,height:part.height)).draw(in:rect(x,y,CGFloat(part.width)/3*magnification,CGFloat(part.height)/3*magnification))
}
func iconBounds(_ icon:[String:Any]) -> CGRect {
    let r=icon["screenFrame"] as! [Double];return CGRect(x:r[0],y:r[1],width:r[2],height:r[3])
}
func figure(_ name:String,_ h:CGFloat,_ draw:()throws->Void) throws {
    height=h
    let b=NSBitmapImageRep(bitmapDataPlanes:nil,pixelsWide:1200,pixelsHigh:Int(h),bitsPerSample:8,samplesPerPixel:4,hasAlpha:true,isPlanar:false,colorSpaceName:.calibratedRGB,bytesPerRow:0,bitsPerPixel:0)!
    NSGraphicsContext.saveGraphicsState();NSGraphicsContext.current=NSGraphicsContext(bitmapImageRep:b)
    NSColor.white.setFill();rect(0,0,1200,h).fill();try draw();NSGraphicsContext.restoreGraphicsState()
    try b.representation(using:.png,properties:[:])!.write(to:output.appendingPathComponent(name))
}
try figure("statusbar-runtime-comparison.png",900) {
    label("系统实测：普通状态栏 → 控制中心",32,22,30)
    label("Simulator 原始截图裁切 · 普通图标保持间距；CC 放大图按图标分开排列",32,68,18,gray)
    for (column,version) in ["17-4","27-0"].enumerated() {
        let x=CGFloat(column)*580+32
        label(column==0 ? "iOS 17.4 · iPhone 15 Pro" : "iOS 27.0 · iPhone 17 Pro",x,116,24)
        let normal=try read(version,"normal"),cc=try read(version,"cc-open")
        let icons=visibleIcons(normal),ccIcons=visibleIcons(cc)
        let union=icons.reduce(CGRect.null){$0.union(iconBounds($1))}.insetBy(dx:-3,dy:-4)
        crop(version,"normal",union,x,165,5)
        label(column==0 ? "普通：size 7 · 间距 7.333 pt" : "普通：size 8 · 间距 9 pt",x,300,20)
        label(column==0 ? "蜂窝 r=1.1667 · Wi-Fi 为三段路径" : "蜂窝 r=1.715 · Wi-Fi 使用 SF Symbols",x,335,18,gray)
        line(x,385,x+530,385)
        crop(version,"cc-open",CGRect(x:28,y:90,width:342,height:25),x,420,1.5)
        label("上：控制中心原始布局",x,470,17,gray)
        for (i,kind) in ["Cellular","Wifi","Battery"].enumerated() {
            let icon=ccIcons.first{($0["class"] as! String).contains(kind)}!
            crop(version,"cc-open",iconBounds(icon).insetBy(dx:-2,dy:-3),x+CGFloat(i)*174,520,4.5)
        }
        label(column==0 ? "展开：size 10 · iconScale 1.16" : "展开：size 12 · iconScale 1.16",x,650,20)
        label(column==0 ? "蜂窝 r=1.2 · 电池填充 r=2.88" : "蜂窝 r=1.68 · 电池填充 r=4.3733",x,690,18,gray)
        label("Wi-Fi / 蜂窝 rounded=false；电池 true",x,730,18,gray)
    }
    line(600,112,600,780)
    label("相同的 iconScale，在不同系统里可以映射到不同 iconSize。",32,810,21)
    label("图中半径为系统字段 / 计算结果；不能替代 Sketch 的平滑圆角参数。",32,850,18,gray)
}
try figure("statusbar-state-comparison.png",690) {
    label("状态回放：充电、百分比、省电与深色",32,22,28)
    label("真实状态栏截图裁切 · 每项同时核对 view 状态和信号格数",32,65,18,gray)
    for (c,v) in ["17-4","27-0"].enumerated() {
        let x=CGFloat(c)*580+32;label(c==0 ? "iOS 17.4" : "iOS 27.0",x,115,24)
        for (r,tag) in ["charging","saver-percent","low-percent-dark"].enumerated() {
            let y=CGFloat(r)*165+165
            let d=try read(v,tag),icons=visibleIcons(d)
            let bounds=icons.reduce(CGRect.null){$0.union(iconBounds($1))}.insetBy(dx:-3,dy:-4)
            crop(v,tag,bounds,x,y,4.5)
            label(["40% · 充电 · 电池内百分比关闭","50% · 省电 · 电池内百分比开启","20% · 深色 · 电池内百分比开启"][r],x,y+115,18,gray)
        }
    }
}
try figure("sketch18-battery-measurements.png",850) {
    label("iOS 18 Sketch：你记得的 2.5 / 3.33",32,22,30)
    label("几何说明图，非 Sketch 原生渲染；完整层级数值见 notes/09 与测量 JSON",32,70,18,gray)
    for (i,isCC) in [false,true].enumerated() {
        let x=CGFloat(i)*580+48,s:CGFloat=13,w:CGFloat=isCC ? 27:25,h:CGFloat=isCC ? 14:13
        label(isCC ? "控制中心顶部电池" : "普通状态栏电池",x,124,24)
        gray.withAlphaComponent(0.45).setStroke()
        let p=NSBezierPath(roundedRect:rect(x,180,w*s,h*s),xRadius:(isCC ? 5:4.3)*s,yRadius:(isCC ? 5:4.3)*s)
        p.lineWidth=s;p.stroke()
        blue.setFill()
        NSBezierPath(roundedRect:rect(x+(isCC ? 1.97561:1.8)*s,206,(isCC ? 23:21)*s,(isCC ? 10:9)*s),xRadius:(isCC ? 3.33:2.5)*s,yRadius:(isCC ? 3.33:2.5)*s).fill()
        label(isCC ? "外框 r=5；填充 r=3.3299999" : "外框 r=4.3000002；填充 r=2.5",x,395,20)
        label(isCC ? "Border 27×14；Capacity 23×10" : "Border 25×13；Capacity 21×9",x,435,18,gray)
    }
    line(32,490,1168,490)
    label("控制中心 cap：椭圆减去矩形",48,520,24)
    let x:CGFloat=310,y:CGFloat=590,s:CGFloat=32
    let oval=rect(x-3.62297496575*s,y-0.32664355*s,4.93902439024*s,5.653287101*s)
    blue.withAlphaComponent(0.12).setFill();NSBezierPath(ovalIn:oval).fill()
    blue.setStroke();NSBezierPath(ovalIn:oval).stroke()
    let removed=rect(x-4.28151155*s,y-1.08041516*s,4.2804878*s,7.1608303*s)
    NSColor.systemOrange.withAlphaComponent(0.2).setFill();removed.fill()
    let context=NSGraphicsContext.current!.cgContext;context.saveGState()
    context.clip(to:rect(x-0.00102375*s,y-1.1*s,2*s,8*s));blue.setFill();NSBezierPath(ovalIn:oval).fill();context.restoreGState()
    label("Oval：4.939024 × 5.653287",530,590,20)
    label("Rectangle：4.280488 × 7.160830",530,630,20)
    label("booleanOperation=1 → Subtract",530,670,20)
    label("并非严格圆，也不是系统 pin 的同一套参数。",530,718,18,gray)
    label("上方圆角为参数示意；cap 图保留子图层原始坐标与比例。",48,810,18,gray)
}
print("Wrote three figures to \(output.path)")
