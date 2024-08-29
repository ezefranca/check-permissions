import Foundation
import ArgumentParser
import Rainbow
import SwiftyTextTable
import permissions_scan_package

struct PermissionScan: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "permissions-scan",
        abstract: "A utility to scan Info.plist files for required permissions.",
        discussion: """
        PermissionScan helps you quickly identify the permissions declared in Info.plist files within your project.
        This is especially useful for ensuring compliance with App Store guidelines and improving transparency with users.
        """,
        version: "1.0.0",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    @Option(name: .shortAndLong, help: "Specify the path to the directory to scan for Info.plist files.")
    var path: String
    
    @Option(name: .shortAndLong, help: "Specify the file to output the results to. (default is console output)")
    var output: String?
    
    @Flag(name: .shortAndLong, help: "Enable verbose output for more detailed information.")
    var verbose: Bool = false
    
    func run() throws {
        let directoryURL = URL(fileURLWithPath: path)
        
        if verbose {
            print("\("🚀".bold) Starting the scanning process...".magenta)
            print("\("📂".bold) Scanning directory: \(directoryURL.path)".magenta)
        }
        
        let checker = PermissionChecker()
        let report = checker.generateReport(for: directoryURL)
        
        if let outputFile = output {
            if verbose {
                print("\("💾".bold) Writing the report to file: \(outputFile)".magenta)
            }
            writeReportToFile(report: report, filePath: outputFile)
        } else {
            if report.isEmpty {
                print("\("⚠️".bold) No permissions found in any Info.plist files.".yellow)
            } else {
                if verbose {
                    print("\("📄".bold) Printing the report to the console...".magenta)
                }
                printReportToConsole(report: report)
            }
        }
        
        if verbose {
            print("\("✅".bold) Scanning process completed.".magenta)
        }
    }
    
    private func writeReportToFile(report: [String: [String]], filePath: String) {
        do {
            let logContent = report.map { plistPath, permissions in
                """
                File: \(plistPath)
                \(permissions.map { " - \($0)" }.joined(separator: "\n"))
                """
            }.joined(separator: "\n\n")
            
            try logContent.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("\("✅".bold) Output written to \(filePath)".green)
        } catch {
            print("\("❌".bold) Failed to write output to file: \(error)".red)
        }
    }
    
    private func printReportToConsole(report: [String: [String]]) {
        var table = TextTable(columns: [
            TextTableColumn(header: "File"),
            TextTableColumn(header: "Permissions")
        ])
        
        for (plistPath, permissions) in report {
            table.addRow(values: [
                plistPath.lightBlue,
                permissions.joined(separator: "\n").green
            ])
        }
        
        print(table.render())
    }
}

PermissionScan.main()
