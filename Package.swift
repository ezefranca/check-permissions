// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "check-permissions",
    platforms: [
        .macOS(.v11),
    ],
    targets: [
        .target(
            name: "check-permissions")
    ]
)
