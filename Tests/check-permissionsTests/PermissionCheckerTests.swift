import XCTest
@testable import check_permissions

final class PermissionCheckerTests: XCTestCase {

    func testFindPlistFiles() {
        let checker = PermissionChecker()
        let testDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: testDirectory, withIntermediateDirectories: true, attributes: nil)

        // Create a test Info.plist file
        let plistPath = testDirectory.appendingPathComponent("Info.plist")
        FileManager.default.createFile(atPath: plistPath.path, contents: nil, attributes: nil)

        let plistFiles = checker.findPlistFiles(in: testDirectory)
        XCTAssertEqual(plistFiles.count, 1)
        XCTAssertEqual(plistFiles.first?.lastPathComponent, "Info.plist")

        // Cleanup
        try? FileManager.default.removeItem(at: testDirectory)
    }

    func testParsePlist() {
        let checker = PermissionChecker()
        let testDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: testDirectory, withIntermediateDirectories: true, attributes: nil)

        // Create a test Info.plist file with some content
        let plistPath = testDirectory.appendingPathComponent("Info.plist")
        let plistContent: [String: Any] = ["NSCameraUsageDescription": "We need access to the camera"]
        let plistData = try! PropertyListSerialization.data(fromPropertyList: plistContent, format: .xml, options: 0)
        FileManager.default.createFile(atPath: plistPath.path, contents: plistData, attributes: nil)

        if let parsedPlist = checker.parsePlist(at: plistPath) {
            XCTAssertEqual(parsedPlist["NSCameraUsageDescription"] as? String, "We need access to the camera")
        } else {
            XCTFail("Failed to parse Info.plist")
        }

        // Cleanup
        try? FileManager.default.removeItem(at: testDirectory)
    }

    func testFindPermissions() {
        let checker = PermissionChecker()
        let testPlistContent: [String: Any] = ["NSCameraUsageDescription": "We need access to the camera", "NSMicrophoneUsageDescription": "We need access to the microphone"]
        
        let foundPermissions = checker.findPermissions(in: testPlistContent)
        XCTAssertTrue(foundPermissions.contains("NSCameraUsageDescription"))
        XCTAssertTrue(foundPermissions.contains("NSMicrophoneUsageDescription"))
    }
}
