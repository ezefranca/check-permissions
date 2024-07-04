
# Check Permissions CLI Tool

## Overview

The **Check Permissions** CLI tool is a Swift-based command line application designed to scan `Info.plist` files in a specified directory and report the permissions requested by each file. This tool is particularly useful for developers working with iOS projects using CocoaPods, as it helps ensure that the necessary permissions are properly declared in the `Pods` directory.

## Features

- **Recursive Scanning**: Searches all subdirectories within the specified `Pods` directory for `Info.plist` files.
- **Permission Detection**: Identifies various permissions requested in `Info.plist` files, such as camera access, location services, and more.
- **User-Friendly Output**: Provides a clear report of permissions for each `Info.plist` file found.

## Installation

### Prerequisites

- macOS 11.0 or later
- Swift 5.3 or later

### Steps

1. **Clone the Repository**:
    ```sh
    git clone <repository-url>
    cd check-permissions
    ```

2. **Run the Installation Script**:
    ```sh
    chmod +x install.sh
    ./install.sh
    ```

The installation script will compile the tool and install it to `/usr/local/bin`, making it available globally as `check-permissions`.

## Usage

### Command-Line Options

- `--path <path>`: Specify the path to the `Pods` directory. This is a required argument.
- `--help`: Display the help message.

### Example Usage

To scan a `Pods` directory for `Info.plist` files and report the permissions:

```sh
check-permissions --path /Users/yourusername/Developer/YourProject/Pods
```

To display the help message:

```sh
check-permissions --help
```

### Sample Output

```
Scanning directory: /Users/yourusername/Developer/YourProject/Pods
Found 3 Info.plist files.
File: /Users/yourusername/Developer/YourProject/Pods/ModuleA/Info.plist
 - NSCameraUsageDescription
 - NSLocationWhenInUseUsageDescription
File: /Users/yourusername/Developer/YourProject/Pods/ModuleB/Info.plist
 - NSMicrophoneUsageDescription
No permissions found in any Info.plist files.
```

## Contributing

We welcome contributions to enhance the functionality of this tool. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License.

---

### `install.sh` Script

For reference, here is the `install.sh` script:

```sh
#!/bin/bash

# Check if Swift is installed
if ! command -v swift &> /dev/null
then
    echo "Swift is not installed. Please install Swift to proceed."
    exit 1
fi

# Build the package
echo "Building the package..."
swift build -c release

# Move the executable to /usr/local/bin
echo "Installing the executable..."
sudo mv .build/release/check-permissions /usr/local/bin/

echo "Installation complete. You can now use the check-permissions command."
```

This `install.sh` script ensures that the tool is built and installed properly, making the `check-permissions` command available globally on your system.
