// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
    targets: [
        .executableTarget(
            name: "check-permissions-cli",
            dependencies: ["check-permissions"],
            path: "Sources/check-permissions-cli"),
        .target(
            name: "check-permissions",
            path: "Sources/check-permissions"),
        .testTarget(
            name: "check-permissionsTests",
            dependencies: ["check-permissions"]),
    ]
)
