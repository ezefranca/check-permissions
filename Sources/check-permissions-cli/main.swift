import Foundation
import check_permissions

func printHelp() {
    print("""
    Usage: check-permissions-cli --path <path_to_Pods_directory> [--output <output_file>]

    Options:
      --path <path>    Specify the path to the Pods directory to scan for Info.plist files.
      --output <file>  Specify the file to output the results to. (default is console output)
      --help           Display this help message.
    """.consoleColor.cyan)
}

func writeReportToFile(report: [String: [String]], filePath: String) {
    do {
        let logContent = report.map { plistPath, permissions in
            """
            File: \(plistPath)
            \(permissions.map { " - \($0)" }.joined(separator: "\n"))
            """
        }.joined(separator: "\n\n")
        
        try logContent.write(toFile: filePath, atomically: true, encoding: .utf8)
        print("Output written to \(filePath)".consoleColor.green)
    } catch {
        print("Failed to write output to file: \(error)".consoleColor.red)
    }
}

func main() {
    let arguments = CommandLine.arguments
    
    if arguments.isEmpty || arguments.contains("--h") ||
        arguments.contains("--help") ||
        arguments.count <= 1 {
        printHelp()
        return
    }
    
    guard arguments.contains("--path") else {
        print("Invalid arguments. Use --help to see usage.".consoleColor.red)
        return
    }
    
    guard let pathIndex = arguments.firstIndex(of: "--path"), pathIndex + 1 < arguments.count else {
        print("Invalid arguments. Use --help to see usage.".consoleColor.red)
        return
    }
    
    let path = arguments[pathIndex + 1]
    let directoryURL = URL(fileURLWithPath: path)
    
    var outputFile: String? = nil
    if let outputIndex = arguments.firstIndex(of: "--output"), outputIndex + 1 < arguments.count {
        outputFile = arguments[outputIndex + 1]
    }
    
    print("Scanning directory: \(directoryURL.path)".consoleColor.magenta)
    
    let checker = PermissionChecker()
    let report = checker.generateReport(for: directoryURL)
    
    if let outputFile = outputFile {
        writeReportToFile(report: report, filePath: outputFile)
    } else {
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
    }
}

main()

