
# permissions-scan-package [![Swift](https://github.com/ezefranca/check-permissions/actions/workflows/swift.yml/badge.svg)](https://github.com/ezefranca/check-permissions/actions/workflows/swift.yml)

[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fezefranca%2Fcheck-permissions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ezefranca/check-permissions)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fezefranca%2Fcheck-permissions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ezefranca/check-permissions)

## Overview

The **permissions-scan** is a Swift-based command line application designed to scan `Info.plist` files in a specified directory and report the permissions requested by each file. This tool is particularly useful for developers working with iOS projects, as it helps ensure that the necessary permissions are properly declared in the project directory.

## Features

- **Recursive Scanning**: Searches all subdirectories within the specified directory for `Info.plist` files.
- **Permission Detection**: Identifies various permissions requested in `Info.plist` files, such as camera access, location services, and more.
- **User-Friendly Output**: Provides a clear report of permissions for each `Info.plist` file found.

## Installation

### Prerequisites

- macOS 12.0 or later
- Swift 5.9 or later

### Steps

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/ezefranca/check-permissions.git
    cd check-permissions
    ```

2. **Run the Installation Script**:
    ```sh
    chmod +x install.sh
    ./setup.sh
    ```

The installation script will compile the tool and install it to `/usr/local/bin`, making it available globally as `permissions-scan`.

## Usage

### Command-Line Options

- `--path <path>`: Specify the path to the directory. This is a required argument.
- `--output <file>`  Specify the file to output the results to. (default is console output)
- `--verbose`: Enable verbose output for more detailed information.
- `--help`: Display the help message.

### Example Usage

To scan a directory for `Info.plist` files and report the permissions:

```sh
permissions-scan --path <directory-path-to-scan>
```

To output to a report log file:

```sh
permissions-scan --path <directory-path-to-scan> --output report
```

To enable verbose output:

```sh
permissions-scan --path <directory-path-to-scan> --verbose
```

To display the help message:

```sh
permissions-scan --help
```

### Sample Output

```sh
🚀 Starting the scanning process...
📂 Scanning directory: /Users/yourusername/Developer/YourProject
Found 3 Info.plist files.
File: /Users/yourusername/Developer/YourProject/ModuleA/Info.plist
 - NSCameraUsageDescription
 - NSLocationWhenInUseUsageDescription
File: /Users/yourusername/Developer/YourProject/ModuleB/Info.plist
 - NSMicrophoneUsageDescription
✅ Scanning process completed.
```

## Using as a Package

To use the **PermissionScan** package in your Swift project, add it as a dependency in your `Package.swift`:

```swift
// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "YourProject",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v9),
        .tvOS(.v15),
        .visionOS(.v1)
    ],
    dependencies: [
        .package(url: "https://github.com/ezefranca/check-permissions", from: "0.0.4"),
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["permissions-scan-package"]),
    ]
)
```

Then import and use it in your code:

```swift
import check_permissions

let checker = PermissionChecker()
let report = checker.generateReport(for: URL(fileURLWithPath: "/path/to/your/project"))
for (plistPath, permissions) in report {
    print("File: \(plistPath)")
    for permission in permissions {
        print(" - \(permission)")
    }
}
```

## Contributing

We welcome contributions to enhance the functionality of this tool. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License.
