import AppKit
// 使用真实采集截图和已验证的独立重绘 PNG 生成研究图。
// swift figures.swift <采集根目录> <重绘目录> <输出目录>
let a=CommandLine.arguments
guard a.count==4 else {fatalError("figures <capture-root> <reconstructed> <output>")}
let output=URL(fileURLWithPath:a[3]);try FileManager.default.createDirectory(at:output,withIntermediateDirectories:true)
var H:CGFloat=730
let ink=NSColor(srgbRed:0.08,green:0.13,blue:0.2,alpha:1), muted=NSColor(srgbRed:0.35,green:0.4,blue:0.48,alpha:1)
let blue=NSColor(srgbRed:0.04,green:0.43,blue:0.73,alpha:1), green=NSColor(srgbRed:0.04,green:0.56,blue:0.4,alpha:1), purple=NSColor(srgbRed:0.48,green:0.29,blue:0.72,alpha:1)
func p(_ x:CGFloat,_ y:CGFloat)->CGPoint{CGPoint(x:x,y:H-y)}
func label(_ s:String,_ x:CGFloat,_ y:CGFloat,_ size:CGFloat=19,_ color:NSColor=NSColor.labelColor){
    (s as NSString).draw(at:p(x,y+size*1.25),withAttributes:[.font:NSFont.systemFont(ofSize:size),.foregroundColor:color==NSColor.labelColor ? ink:color])
}
func line(_ x:CGFloat,_ y:CGFloat,_ x2:CGFloat,_ y2:CGFloat,_ color:NSColor=NSColor.gray){let b=NSBezierPath();b.move(to:p(x,y));b.line(to:p(x2,y2));b.lineWidth=1.5;color.setStroke();b.stroke()}
func dimension(_ x:CGFloat,_ y:CGFloat,_ x2:CGFloat,_ text:String){line(x,y,x2,y,blue);line(x,y-5,x,y+5,blue);line(x2,y-5,x2,y+5,blue);label(text,(x+x2)/2-CGFloat(text.count)*5,y+8,17,blue)}
func draw(_ image:CGImage,_ x:CGFloat,_ y:CGFloat,_ w:CGFloat,_ h:CGFloat){NSImage(cgImage:image,size:CGSize(width:image.width,height:image.height)).draw(in:NSRect(x:x,y:H-y-h,width:w,height:h),from:.zero,operation:.sourceOver,fraction:1)}
func bitmap(_ path:String)throws->NSBitmapImageRep {NSBitmapImageRep(data:try Data(contentsOf:URL(fileURLWithPath:path)))!}
func read(_ path:String)throws->[String:Any]{try JSONSerialization.jsonObject(with:Data(contentsOf:URL(fileURLWithPath:path))) as! [String:Any]}
func figure(_ name:String,_ height:CGFloat,_ body:()throws->Void)throws {
    H=height
    let b=NSBitmapImageRep(bitmapDataPlanes:nil,pixelsWide:1300,pixelsHigh:Int(height),bitsPerSample:8,samplesPerPixel:4,hasAlpha:true,isPlanar:false,colorSpaceName:.calibratedRGB,bytesPerRow:0,bitsPerPixel:0)!
    NSGraphicsContext.saveGraphicsState();NSGraphicsContext.current=NSGraphicsContext(bitmapImageRep:b)
    NSColor.white.setFill();NSRect(x:0,y:0,width:1300,height:height).fill();NSGraphicsContext.current!.imageInterpolation = .none
    try body();NSGraphicsContext.restoreGraphicsState()
    try b.representation(using:.png,properties:[:])!.write(to:output.appendingPathComponent(name))
}
let models=[("notch","iPhone 14 · 刘海",4),("island","iPhone 15 Pro · 灵动岛",7),("island-max","iPhone 15 Pro Max · 灵动岛",8)]
for state in ["full","partial"] {
    try figure("signals-\(state)-comparison.png",830) {
        label("iOS 17.4 模拟器：系统状态栏实测",32,22,29)
        label("\(state=="full" ? "满格信号" : "蜂窝 2 格 / Wi-Fi 1 格") · 无电池百分比 · 原始截图像素放大 3× · 各行倍率相同",32,68,19,muted)
        for (index,model) in models.enumerated() {
            let (folder,title,size)=model, j=try read("\(a[1])/\(folder)/\(state).json")
            let icons=j["icons"] as! [[String:Any]], scale=j["scale"] as! Double
            let frames=icons.map{$0["screenFrame"] as! [Double]}
            let minX=frames.map{$0[0]}.min()!-3, minY=frames.map{$0[1]}.min()!-3
            let maxX=frames.map{$0[0]+$0[2]}.max()!+3,maxY=frames.map{$0[1]+$0[3]}.max()!+3
            let rect=CGRect(x:floor(minX*scale),y:floor(minY*scale),width:ceil(maxX*scale)-floor(minX*scale),height:ceil(maxY*scale)-floor(minY*scale))
            let shot=try bitmap("\(a[1])/\(folder)/\(state)-screen.png")
            let crop=shot.cgImage!.cropping(to:rect)!, y=CGFloat(120+index*230),x:CGFloat=365
            label(title,32,y+16,21);label("iconSize = \(size)",32,y+53,18,muted)
            draw(crop,x,y,CGFloat(crop.width*3),CGFloat(crop.height*3))
            for i in 0..<2 {
                let start=frames[i][0]+frames[i][2],end=frames[i+1][0]
                dimension(x+CGFloat(start*scale-rect.minX)*3,y+CGFloat(crop.height*3)+13,
                          x+CGFloat(end*scale-rect.minX)*3,String(format:"%.3g pt",end-start))
            }
        }
    }
}
try figure("signals-size7-anatomy.png",660) {
    label("第 7 档：图标内部的几何",32,22,29)
    label("独立重绘已与系统导出验证 · 单位 pt · 实际状态栏分支 rounded = NO",32,68,19,muted)
    let x:CGFloat=90,y:CGFloat=190,s:CGFloat=20,w:CGFloat=58/3,h:CGFloat=37/3
    let cell=try bitmap("\(a[2])/Cellular-7-rounded0-active4.png")
    draw(cell.cgImage!,x,y,w*s,h*s)
    dimension(x,140,x+w*s,"19⅓ pt")
    let heights:[CGFloat]=[14/3,7,29/3,37/3]
    for (i,v) in heights.enumerated(){label(String(format:"%.3g",Double(v)),x+CGFloat(i)*16/3*s+10,y+(h-v)*s-31,17,muted)}
    dimension(x,y+h*s+24,x+10/3*s,"3⅓ pt")
    dimension(x+10/3*s,y+h*s+76,x+16/3*s,"2 pt")
    label("柱宽",x,y+h*s+125,18,muted);label("圆角参数 1⅙ pt · continuous",x+110,y+h*s+125,18,muted)
    let wx:CGFloat=780,wy:CGFloat=190,ww:CGFloat=17
    let colors=[purple,green,blue]
    for i in 0..<3 {
        let src=try bitmap(String(format:"%@/Wifi-7-rounded0-layer%02d.png",a[2],i+1))
        let tinted=NSBitmapImageRep(bitmapDataPlanes:nil,pixelsWide:src.pixelsWide,pixelsHigh:src.pixelsHigh,bitsPerSample:8,samplesPerPixel:4,hasAlpha:true,isPlanar:false,colorSpaceName:.calibratedRGB,bytesPerRow:0,bitsPerPixel:0)!
        let bytes=tinted.bitmapData!
        let context=CGContext(data:bytes,width:src.pixelsWide,height:src.pixelsHigh,bitsPerComponent:8,bytesPerRow:tinted.bytesPerRow,space:CGColorSpaceCreateDeviceRGB(),bitmapInfo:CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.draw(src.cgImage!,in:CGRect(x:0,y:0,width:src.pixelsWide,height:src.pixelsHigh))
        let color=colors[i].usingColorSpace(.deviceRGB)!
        for py in 0..<src.pixelsHigh {for px in 0..<src.pixelsWide {
            let offset=py*tinted.bytesPerRow+px*4,alpha=CGFloat(bytes[offset+3])
            bytes[offset]=UInt8((color.redComponent*alpha).rounded())
            bytes[offset+1]=UInt8((color.greenComponent*alpha).rounded())
            bytes[offset+2]=UInt8((color.blueComponent*alpha).rounded())
        }}
        draw(tinted.cgImage!,wx,wy,ww*s,h*s)
    }
    dimension(wx,140,wx+ww*s,"17 pt")
    let bands:[(CGFloat,String,NSColor)]=[(2.5,"2.5",blue),(1.75,"间距 1.75",muted),(2.5,"2.5",green),(1.75,"间距 1.75",muted),(23/6,"3⅚",purple)]
    var by=wy
    for (height,title,color) in bands {
        let end=by+height*s,rx:CGFloat=1160
        line(rx,by,rx,end,color);line(rx-5,by,rx+5,by,color);line(rx-5,end,rx+5,end,color)
        label(title,rx+12,(by+end)/2-12,17,color);by=end
    }
    label("三层着色仅用于区分形状",wx,y+h*s+33,18,muted)
    label("实际描边线宽 ⅔ pt；不等于弧线厚度",700,y+h*s+125,18,muted)
}
