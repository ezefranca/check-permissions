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
sudo mv .build/release/check-permissions-cli /usr/local/bin/

echo "Installation complete. You can now use the check-permissions-cli command."
