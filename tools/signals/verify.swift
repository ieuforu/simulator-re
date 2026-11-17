import AppKit
// 比较图标 alpha，不让颜色空间转换掩盖几何误差。两组均为黑色透明图。
// swift verify.swift <系统导出目录> <独立重绘目录> [真实采集根目录]
let args=CommandLine.arguments
guard args.count==3 || args.count==4 else {fatalError("verify <system-directory> <reconstruction-directory> [live-root]")}
var worst=0.0, checked=0, failures=0
func compare(_ name: String, _ paths: [URL]) throws {
    let images=try paths.map{NSBitmapImageRep(data:try Data(contentsOf:$0))!}
    let a=images[0],b=images[1]
    guard a.pixelsWide==b.pixelsWide && a.pixelsHigh==b.pixelsHigh else {fatalError("size mismatch: \(name)")}
    var sum=0.0,maxDelta=0.0,big=0
    for y in 0..<a.pixelsHigh { for x in 0..<a.pixelsWide {
        let d=abs(a.colorAt(x:x,y:y)!.alphaComponent-b.colorAt(x:x,y:y)!.alphaComponent)*255
        sum+=d;maxDelta=max(maxDelta,d);if d>1.01 {big+=1}
    }}
    let mean=sum/Double(a.pixelsWide*a.pixelsHigh)
    print(String(format:"%@ mean=%.6f max=%.3f pixels>1=%d",name,mean,maxDelta,big))
    checked+=1;worst=max(worst,maxDelta);if big>0 {failures+=1}
}
for size in [4,7,8] { for rounded in [0,1] {
    let names=(1...3).map{String(format:"Wifi-%d-rounded%d-layer%02d.png",size,rounded,$0)} +
        (0...4).map{"Cellular-\(size)-rounded\(rounded)-active\($0).png"}
    for name in names {
        let paths=[args[1],args[2]].map{URL(fileURLWithPath:$0).appendingPathComponent(name)}
        try compare(name,paths)
    }
}}
if args.count==4 {
    func read(_ url:URL) throws -> [String:Any] {try JSONSerialization.jsonObject(with:Data(contentsOf:url)) as! [String:Any]}
    for device in ["notch","island","island-max"] {for state in ["full","partial"] {
        let dir=URL(fileURLWithPath:args[3]).appendingPathComponent(device)
        let capture=try read(dir.appendingPathComponent("\(state).json"))
        for icon in capture["icons"] as! [[String:Any]] {
            let cls=icon["class"] as! String,size=icon["iconSize"] as! Int,rounded=(icon["rounded"] as! Bool) ? 1:0
            let layers=(icon["layer"] as! [String:Any])["children"] as! [[String:Any]]
            if cls=="STUIStatusBarWifiSignalView" {
                for (i,layer) in layers.enumerated() {
                    let name=String(format:"Wifi-%d-rounded%d-layer%02d.png",size,rounded,i+1)
                    try compare("live/\(device)/\(state)/\(name)",[dir.appendingPathComponent(layer["image"] as! String),URL(fileURLWithPath:args[2]).appendingPathComponent(name)])
                }
            } else if cls=="STUIStatusBarCellularSignalView" {
                let fixture=try read(URL(fileURLWithPath:args[1]).appendingPathComponent("Cellular-\(size)-rounded\(rounded).json"))
                let expected=(fixture["layer"] as! [String:Any])["children"] as! [[String:Any]]
                guard layers.count==expected.count else {fatalError("cell layer count")}
                for (l,r) in zip(layers,expected) {
                    for (a,b) in zip(l["frame"] as! [Double],r["frame"] as! [Double]) {guard abs(a-b)<1e-10 else {fatalError("cell frame mismatch")}}
                    guard abs((l["cornerRadius"] as! Double)-(r["cornerRadius"] as! Double))<1e-10,
                          (l["cornerCurve"] as! String)==(r["cornerCurve"] as! String) else {fatalError("cell corner mismatch")}
                }
                print("live/\(device)/\(state): 4 cellular frames and corner settings match")
            }
        }
    }}
}
print("Compared \(checked) images; max alpha delta=\(worst); images with delta > 1/255=\(failures)")
if failures>0 {exit(1)}
