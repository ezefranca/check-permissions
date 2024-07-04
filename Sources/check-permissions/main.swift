import Foundation

func findPlistFiles(in directory: URL) -> [URL] {
    var plistFiles = [URL]()
    let fileManager = FileManager.default
    if let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: nil) {
        for case let fileURL as URL in enumerator {
            if fileURL.lastPathComponent == "Info.plist" {
                plistFiles.append(fileURL)
            }
        }
    }
    return plistFiles
}

func parsePlist(at url: URL) -> [String: Any]? {
    if let data = try? Data(contentsOf: url) {
        return try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
    }
    return nil
}

func findPermissions(in dictionary: [String: Any]) -> [String] {
    let permissionsKeys = [
        "NSAppleMusicUsageDescription",
        "NSBluetoothPeripheralUsageDescription",
        "NSCalendarsUsageDescription",
        "NSCameraUsageDescription",
        "NSContactsUsageDescription",
        "NSFaceIDUsageDescription",
        "NSHealthShareUsageDescription",
        "NSHealthUpdateUsageDescription",
        "NSHomeKitUsageDescription",
        "NSLocationUsageDescription",
        "NSLocationAlwaysUsageDescription",
        "NSLocationWhenInUseUsageDescription",
        "NSMicrophoneUsageDescription",
        "NSMotionUsageDescription",
        "NFCReaderUsageDescription",
        "NSPhotoLibraryUsageDescription",
        "NSPhotoLibraryAddUsageDescription",
        "NSRemindersUsageDescription",
        "NSSiriUsageDescription",
        "NSSpeechRecognitionUsageDescription"
    ]
    
    var foundPermissions = [String]()
    
    for key in permissionsKeys {
        if dictionary[key] != nil {
            foundPermissions.append(key)
        }
    }
    
    return foundPermissions
}

func printHelp() {
    print("""
    Usage: check-permissions --path <path_to_Pods_directory>

    Options:
      --path <path>    Specify the path to the Pods directory to scan for Info.plist files.
      --help           Display this help message.
    """)
}

func main() {
    let arguments = CommandLine.arguments
    
    guard arguments.count == 3 || (arguments.count == 2 && arguments[1] == "--help") else {
        print("Invalid arguments. Use --help to see usage.")
        return
    }
    
    if arguments.count == 2 && arguments[1] == "--help" {
        printHelp()
        return
    }
    
    guard arguments[1] == "--path" else {
        print("Invalid arguments. Use --help to see usage.")
        return
    }
    
    let path = arguments[2]
    let directoryURL = URL(fileURLWithPath: path)
    
    print("Scanning directory: \(directoryURL.path)")  // Debugging output
    let plistFiles = findPlistFiles(in: directoryURL)
    print("Found \(plistFiles.count) Info.plist files.")  // Debugging output

    var report = [String: [String]]()
    
    for plistFile in plistFiles {
        if let plist = parsePlist(at: plistFile) {
            let permissions = findPermissions(in: plist)
            if !permissions.isEmpty {
                report[plistFile.path] = permissions
            }
        } else {
            print("Failed to parse \(plistFile.path)")  // Debugging output
        }
    }
    
    if report.isEmpty {
        print("No permissions found in any Info.plist files.")
    } else {
        for (plistPath, permissions) in report {
            print("File: \(plistPath)")
            for permission in permissions {
                print(" - \(permission)")
            }
        }
    }
}

main()
