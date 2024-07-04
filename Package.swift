// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "check-permissions",
    platforms: [
        .macOS(.v11),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "check-permissions",
            dependencies: []),
        .testTarget(
            name: "check-permissionsTests",
            dependencies: ["check-permissions"]),
    ]
) 
