// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "check-permissions",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v9),
        .tvOS(.v15),
        .visionOS(.v1)
    ],
    products: [
        .executable(name: "check-permissions-cli", targets: ["check-permissions-cli"]),
        .library(name: "check-permissions", targets: ["check-permissions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
        .package(url: "https://github.com/tuist/XcodeProj.git", from: "8.23.2"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.1"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.9.0"),
    ],
    targets: [
        .executableTarget(
            name: "check-permissions-cli",
            dependencies: [
                "check-permissions",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Rainbow",
                "SwiftyTextTable"
            ],
            path: "Sources/check-permissions-cli"),
        .target(
            name: "check-permissions",
            path: "Sources/check-permissions"),
        .testTarget(
            name: "check-permissions-packageTests",
            dependencies: ["check-permissions"],
            path: "Tests/check-permissions-packageTests")
    ]
)
