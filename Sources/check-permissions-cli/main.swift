import Foundation
import check_permissions

func printHelp() {
    print("""
    Usage: check-permissions-cli --path <path_to_Pods_directory> [--output <output_file>]

    Options:
      --path <path>    Specify the path to the Pods directory to scan for Info.plist files.
      --output <file>  Specify the file to output the results to.
      --help           Display this help message.
    """.consoleColor.blue)
}

func main() {
    let arguments = CommandLine.arguments
    
    guard arguments.contains("--path") else {
        print("Invalid arguments. Use --help to see usage.".consoleColor.red)
        return
    }
    
    if arguments.contains("--help") {
        printHelp()
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
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: report, options: .prettyPrinted)
            try jsonData.write(to: URL(fileURLWithPath: outputFile))
            print("Output written to \(outputFile)".consoleColor.green)
        } catch {
            print("Failed to write output to file: \(error)".consoleColor.red)
        }
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
