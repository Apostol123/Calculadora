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
    @Published private var newRow: Bool = false
    
    
    public  func observeEvent(_ event: Event) {
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
            react(to: action)
        case .idle:
            break
        }
    }
    
   
    private func react(to action: Action) {
        if action != .separator {
            newRow = true
        }
        
        if currentAction != action && action != .result {
            lastText = text
        }
        
        switch action {
        case .reset:
            text = ""
            lastText = ""
            currentAction = .idle
            
        case .add:
            if currentAction == action {
                print(add(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = add(value: lastText)
                lastText = text
            }
            
        case .subtract:
            if currentAction == action {
                print(substract(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = substract(value: lastText)
                lastText = text
            }
            
        case .multiply:
            if currentAction == action {
                print(multiply(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = multiply(value: lastText)
                lastText = text
            }
            
        case .split:
            if currentAction == action {
                print(split(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = split(value: lastText)
                lastText = text
            }
            
        case .toggleValueType:
            text = formatNumberWithDots(text, toggleValueType: true)
            
        case .result:
            react(to: currentAction)
            
        case .percentage:
            text = percentage()
            
        case .separator:
            if text.last != ".", !text.isEmpty {
                text.append(".")
            }
                
        default:
            break
        }
        
        currentAction = action
    }

    @Published public var lastText: String = ""
    @Published public var text: String = ""
    @Published private var currentAction: Action = .idle
    
    public init() {}
    
    private func add(value: String) -> String {
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text) else { return value }
        let total = doubleValue + doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    private func percentage() -> String {
        guard let doubleCurrentValue = Double(text) else { return text }
        let total = doubleCurrentValue / 100
        return NSNumber(value: total).stringValue
    }
    
    private func substract(value: String) -> String {
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text) else { return value }
        let total = doubleValue - doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    private func split(value: String) -> String {
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text) else { return value }
        let total = doubleValue / doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    private func multiply(value: String) -> String {
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text) else { return value }
        let total = doubleValue * doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    func formatNumberWithDots(_ number: String, toggleValueType: Bool = false) -> String {
        // Remove any non-numeric characters
        var cleanNumber = number
        if !toggleValueType {
            cleanNumber = number.filter {$0.isNumber}
        }
        
        // Reverse the string for easier processing
        let reversedString = String(cleanNumber.reversed())
        
        // Insert dots every three characters
        var separatedReversedString = ""
        if let intNumber = Int(number.replacingOccurrences(of: ".", with: "")), intNumber > 9999 {
            for (index, character) in reversedString.enumerated() {
                if index > 0 && index % 3 == 0 {
                    separatedReversedString.append(".")
                }
                separatedReversedString.append(character)
            }
        } else {
            separatedReversedString = reversedString
        }
        
        // Reverse the string back to the original order
        var formattedString = String(separatedReversedString.reversed())
        
        if toggleValueType {
            if text.contains("-") {
                return formattedString.replacingOccurrences(of: "-", with: "")
            } else {
                formattedString = "-\(String(separatedReversedString.reversed()))"
            }
        }
        
        return formattedString
    }
}

