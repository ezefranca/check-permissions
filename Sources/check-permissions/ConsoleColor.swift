// Source: https://stackoverflow.com/questions/27807925/color-ouput-with-swift-command-line-tool
import Foundation

public extension String {
    var consoleColor: ColoredConsoleString {
        ColoredConsoleString(self)
    }
}

public class ColoredConsoleString {
    var string: String
    
    public enum ColorSelectors: String {
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case magenta = "\u{001B}[0;35m"
        case cyan = "\u{001B}[0;36m"
        case reset = "\u{001B}[0;0m"
    }
    
    init(_ str: String) {
        string = str
    }
    
    public var red: String {
        wrappedString(color: .red, string)
    }
    
    public var green: String {
        wrappedString(color: .green, string)
    }
    
    public var yellow: String {
        wrappedString(color: .yellow, string)
    }
    
    public var blue: String {
        wrappedString(color: .blue, string)
    }
    
    public var magenta: String {
        wrappedString(color: .magenta, string)
    }
    
    public var cyan: String {
        wrappedString(color: .cyan, string)
    }
    
    private func wrappedString(color: ColorSelectors, _ string: String) -> String {
        return "\(color.rawValue)\(string)\(ColorSelectors.reset.rawValue)"
    }
}