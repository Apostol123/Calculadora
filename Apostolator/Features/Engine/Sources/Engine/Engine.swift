// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Combine

public enum Event {
    case value(String)
    case action(Action)
    case idle
    
    public var currentValue: String {
        switch self {
        case .value(let value):
            return value
        default:
            return String(0)
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
    @Published private var results: [String] = []
    
    private lazy var numberFormmated: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    
    public  func observeEvent(_ event: Event) {
        switch event {
        case .value:
            
            if event.currentValue == ",", text.last != "," {
                text.append(",")
                return
            }
            
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
                text = formatNumberWithDots(add(value: lastText))
                results.append(text)
                lastText = text
            }
            
        case .subtract:
            if currentAction == action {
                print(substract(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = formatNumberWithDots(substract(value: lastText))
                lastText = text
                results.append(text)
            }
            
        case .multiply:
            if currentAction == action {
                print(multiply(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = formatNumberWithDots(multiply(value: lastText))
                lastText = text
                results.append(text)
            }
            
        case .split:
            if currentAction == action {
                print(split(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                text = formatNumberWithDots(split(value: lastText))
                lastText = text
                results.append(text)
            }
            
        case .toggleValueType:
            text = formatNumberWithDots(text, toggleValueType: true)
            
        case .result:
            react(to: currentAction)
            
        case .percentage:
            text = percentage()
                
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
        let value = value.replacingOccurrences(of: ",", with: ".")
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: ".")) else { return value }
        let total = doubleValue + doubleCurrentValue
        return numberFormmated.string(from:  NSNumber(value: total)) ?? text
    }
    
    private func percentage() -> String {
        let text = text.replacingOccurrences(of: ",", with: ".")
        guard let doubleCurrentValue = Double(text) else { return text }
        let total = doubleCurrentValue / 100
        return numberFormmated.string(from:  NSNumber(value: total)) ?? text
    }
    
    private func substract(value: String) -> String {
        let value = value.replacingOccurrences(of: ",", with: ".")
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: ".")) else { return value }
        let total = doubleValue - doubleCurrentValue
        return numberFormmated.string(from:  NSNumber(value: total)) ?? text
    }
    
    private func split(value: String) -> String {
        let value = value.replacingOccurrences(of: ",", with: ".")
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: ".")) else { return value }
        let total = doubleValue / doubleCurrentValue
        return numberFormmated.string(from:  NSNumber(value: total)) ?? text
    }
    
    private func multiply(value: String) -> String {
        let value = value.replacingOccurrences(of: ",", with: ".")
        guard let doubleValue = Double(value), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: ".")) else { return value }
        let total = doubleValue * doubleCurrentValue
        return numberFormmated.string(from:  NSNumber(value: total)) ?? text
    }
    
    func formatNumberWithDots(_ number: String, toggleValueType: Bool = false) -> String {
        // Remove any non-numeric characters
        let cleanNumber = number
        var decimals: String?
       
        
        // Reverse the string for easier processing
        let reversedString = String(cleanNumber.reversed())
        if text.contains(",") {
            decimals = text.split(separator: ",").map {String($0)}.first
        }
        
        // Insert dots every three characters
        var separatedReversedString = ""
        if let intNumber = Int(number.replacingOccurrences(of: ".", with: "")), intNumber > 9999 {
          
                for (index, character) in reversedString.filter({$0.isNumber}).enumerated() {
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
        
        if let decimals = decimals, !text.contains(",") {
            formattedString.append(","+decimals)
        }
        return formattedString
    }
}

