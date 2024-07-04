import Foundation

func printHelp() {
    print("""
    Usage: check-permissions --path <path_to_Pods_directory>

    Options:
      --path <path>    Specify the path to the Pods directory to scan for Info.plist files.
      --help           Display this help message.
    """.consoleColor.blue)
}

func main() {
    let arguments = CommandLine.arguments
    
    guard arguments.count == 3 || (arguments.count == 2 && arguments[1] == "--help") else {
        print("Invalid arguments. Use --help to see usage.".consoleColor.red)
        return
    }
    
    if arguments.count == 2 && arguments[1] == "--help" {
        printHelp()
        return
    }
    
    guard arguments[1] == "--path" else {
        print("Invalid arguments. Use --help to see usage.".consoleColor.red)
        return
    }
    
    let path = arguments[2]
    let directoryURL = URL(fileURLWithPath: path)
    
    print("Scanning directory: \(directoryURL.path)".consoleColor.magenta)
    
    let checker = PermissionChecker()
    checker.printReport(for: directoryURL)
}

main()
