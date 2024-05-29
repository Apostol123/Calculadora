// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Combine

public enum Event {
    case value(Int)
    case action(Action)
    case idle
    
    public var currentValue: Int {
        switch self {
        case .value(let value):
            return value
        default:
            return 0
        }
    }
    
    public var currentAction: Action  {
        switch self {
        case .action(let action):
            return action
        default:
            return .idle
        }
    }
}

public enum Action {
    case split
    case multiply
    case add
    case subtract
    case reset
    case percentage
    case toggleValueType
    case result
    case separator
    case idle
}


public final class Engine: ObservableObject {
    
    private var numberForrmater: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 12
        return numberFormatter
    }()
    
    @Published private var newRow: Bool = false
    
    
    public  func observeEvent(_ event: Event) {
        currentEventValue = event.currentValue
        switch event {
        case .value:
            
            if text.count <= 11 {
                text.append(String(event.currentValue))
                text = formatNumberWithDots(text)
            }
            
            if newRow {
                text = ""
                text.append(String(event.currentValue))
            }
            
            newRow = false
            
        case .action(let action):
            if currentAction != action {
                lastText = text
            }
            
            newRow = true
            switch action {
            case .add:
                if currentAction == action {
                    print(add(value: lastText))
                    print("text: \(text)")
                    print("lastText: \(lastText)")
                    text = add(value: lastText)
                    lastText = text
                    
                }
            default : break
            }
            react(to: event.currentAction)
            
        case .idle:
            break
        }
    }
    
    private func add(value: String) -> String {
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text) else { return value }
        let total = doubleValue + doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    
    func formatNumberWithDots(_ number: String) -> String {
        // Remove any non-numeric characters
        let cleanNumber = number.filter { $0.isNumber }
        
        // Reverse the string for easier processing
        let reversedString = String(cleanNumber.reversed())
        
        // Insert dots every three characters
        var separatedReversedString = ""
        for (index, character) in reversedString.enumerated() {
            if index > 0 && index % 3 == 0 {
                separatedReversedString.append(".")
            }
            separatedReversedString.append(character)
        }
        
        // Reverse the string back to the original order
        let formattedString = String(separatedReversedString.reversed())
        
        return formattedString
    }
    
    
    private func addSeparatorIfNeeded(value: String) -> String {
        guard let doubleValue = Int(value),
              let formattedNumber = numberForrmater.string(from: NSNumber(value: doubleValue)) else { return value}
        return formattedNumber
    }
    
    private func react(to action: Action) {
        currentAction = action
        switch action {
        case .reset:
            text = ""
        default:
            break
        }
    }
    
    @Published public var currentEventValue: Int = 0
    @Published public var lastText: String = ""
    @Published public var text: String = ""
    @Published private var currentAction: Action = .idle
    
    public init() {}
}

