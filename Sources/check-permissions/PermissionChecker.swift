import Foundation

public class PermissionChecker {
    
    let permissionsKeys: [String] = [
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
    
    public func findPlistFiles(in directory: URL) -> [URL] {
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
    
    public func parsePlist(at url: URL) -> [String: Any]? {
        if let data = try? Data(contentsOf: url) {
            return try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
        }
        return nil
    }
    
    public func findPermissions(in dictionary: [String: Any]) -> [String] {
        var foundPermissions = [String]()
        
        for key in permissionsKeys {
            if dictionary[key] != nil {
                foundPermissions.append(key)
            }
        }
        
        return foundPermissions
    }
    
    public func generateReport(for directoryURL: URL) -> [String: [String]] {
        let plistFiles = findPlistFiles(in: directoryURL)
        var report = [String: [String]]()
        
        for plistFile in plistFiles {
            if let plist = parsePlist(at: plistFile) {
                let permissions = findPermissions(in: plist)
                if !permissions.isEmpty {
                    report[plistFile.path] = permissions
                }
            } else {
                print("Failed to parse \(plistFile.path)".consoleColor.red)
            }
        }
        
        return report
    }
    
    @discardableResult
    public func printReport(for directoryURL: URL) -> [String: [String]] {
        let report = generateReport(for: directoryURL)
        
        if report.isEmpty {
            print("No permissions found in any Info.plist files.".consoleColor.yellow)
        } else {
            for (plistPath, permissions) in report {
                print("File: \(plistPath)".consoleColor.cyan)
                for permission in permissions {
                    print(" - \(permission)".consoleColor.green)
                }
            }
        }
        
        return report
    }
}
