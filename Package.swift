// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "permissions-scan-package",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v9),
        .tvOS(.v15),
        .visionOS(.v1)
    ],
    products: [
        .executable(name: "permissions-scan", targets: ["permissions-scan"]),
        .library(name: "permissions-scan-package", targets: ["permissions-scan-package"]),
    ], 
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
        .package(url: "https://github.com/tuist/XcodeProj.git", from: "8.23.2"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.1"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.9.0"),
    ],
    targets: [
        .executableTarget(
            name: "permissions-scan",
            dependencies: [
                "permissions-scan-package",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Rainbow",
                "SwiftyTextTable"
            ],
            path: "Sources/permissions-scan"), // Only main.swift should be here
        .target(
            name: "permissions-scan-package",
            path: "Sources/permissions-scan-package"), // Only PermissionChecker.swift and other library files
        .testTarget(
            name: "permissions-scan-packageTests",
            dependencies: ["permissions-scan-package"],
            path: "Tests/check-permissionsTests") // Ensure test paths are correct
    ]
)
