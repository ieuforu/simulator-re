// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "simre",
    platforms: [.macOS(.v14)],
    targets: [.executableTarget(name: "simre")]
)
