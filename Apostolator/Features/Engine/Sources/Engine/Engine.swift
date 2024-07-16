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

public enum Action: Equatable {
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
    
   case landscapeAction(LandscapeAction)
}

public enum LandscapeAction: Equatable {
    case rand
    case pi
    case tanh
    case cosh
    case sinh
    case tan
    case sin
    case cos
}


public final class Engine: ObservableObject {
    @Published private var newRow: Bool = false
    @Published public var results: [ResultModel] = []
    @Published public var decimals: Int = 16
    @Published public var lastText: String = ""
    @Published public var text: String = "0"
    @Published public var currentAction: Action = .idle
    private var maxNumberLength: Int = 11


    public init() {}
    
    
    public  func observeEvent(_ event: Event) {
        switch event {
        case .value:
            
            if text.count == 1 && text.contains("0") && event.currentValue == "0" {
                return
            }
            
            if text.count == 1, text.contains("0"), let char = event.currentValue.first, char.isNumber{
                text = ""
            }
            
            if event.currentValue == ",", text.last != "," {
                text.append(",")
                return
            }
            
            if String(event.currentValue).count <= maxNumberLength && lastText.count <= maxNumberLength {
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
        guard lastText.count <= maxNumberLength  else { return }
        if action != .separator {
            newRow = true
        }
        
        if currentAction != action && action != .result {
            lastText = text
        }
        
        switch action {
        case .reset:
            text = "0"
            lastText = ""
            currentAction = .idle
            
        case .add:
            if currentAction == action {
                print(add(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                var resultModel: ResultModel = ResultModel(result: "", lastResult: "", total: "", action: action)
                resultModel.lastValue = text
                resultModel.firstValue = lastText
                
                text = formatNumberWithDots(add(value: lastText))
                resultModel.total = text
                results.append(resultModel)
                lastText = text
            }
            
        case .subtract:
            if currentAction == action {
                print(substract(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                var resultModel: ResultModel = ResultModel(result: "", lastResult: "", total: "", action: action)
                resultModel.lastValue = text
                resultModel.firstValue = lastText
                
                text = formatNumberWithDots(substract(value: lastText))
                lastText = text
                resultModel.total = text
                results.append(resultModel)
            }
            
        case .multiply:
            if currentAction == action {
                print(multiply(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                var resultModel: ResultModel = ResultModel(result: "", lastResult: "", total: "", action: action)
                resultModel.lastValue = text
                resultModel.firstValue = lastText
                
                text = formatNumberWithDots(multiply(value: lastText))
                lastText = text
                resultModel.total = text
                results.append(resultModel)
            }
            
        case .split:
            if currentAction == action {
                print(split(value: lastText))
                print("text: \(text)")
                print("lastText: \(lastText)")
                
                var resultModel: ResultModel = ResultModel(result: "", lastResult: "", total: "", action: action)
                resultModel.lastValue = text
                resultModel.firstValue = lastText
                
                text = formatNumberWithDots(split(value: lastText))
                lastText = text
                resultModel.total = text
                results.append(resultModel)
            }
            
        case .toggleValueType:
            text = formatNumberWithDots(text, toggleValueType: true)
            
        case .result:
            react(to: currentAction)
            
        case .percentage:
            
            var resultModel: ResultModel = ResultModel(result: "", lastResult: "", total: "", action: action)
            resultModel.lastValue = text
            resultModel.firstValue = lastText
            
            text = percentage()
            
            resultModel.total = text
            results.append(resultModel)
         
        case .landscapeAction(let landscapeAction):
            switch  landscapeAction {
            case .rand:
                text = formatNumberWithDots( "\(arc4random())")
            case .pi:
                self.observeEvent(.value("\(Double.pi)"))
                
            case .tanh:
                if text != "0" {
                    self.observeEvent(.value("\(tanh(Double(text) ?? 0))"))
                }
                
            case .cosh:
                if text != "0" {
                    self.observeEvent(.value("\(cosh(Double(text) ?? 0))"))
                }
                
            case .sinh:
                if text != "0" {
                    self.observeEvent(.value("\(sinh(Double(text) ?? 0))"))
                }
        
            case .tan:
                if text != "0" {
                    self.observeEvent(.value("\(tan(Double(text) ?? 0))"))
                    
                }
                
            case .sin:
                if text != "0" {
                    self.observeEvent(.value("\(sin(Double(text) ?? 0))"))
                }
                
            case .cos:
                if text != "0" {
                    self.observeEvent(.value("\(cos(Double(text) ?? 0))"))
                }
            }
            
            
                
        default:
            break
        }
        
        currentAction = action
    }

   
    public func updateNumberLength(_ newValue: Int) {
        self.react(to: .reset)
        self.maxNumberLength = newValue
    }
    
    private func add(value: String) -> String {
        guard let doubleValue = Double(value.replacingOccurrences(of: ",", with: "")), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: "")) else { return value }
        let total = doubleValue + doubleCurrentValue
        return  NSNumber(value: total).stringValue
    }
    
    private func percentage() -> String {
        let text = text.replacingOccurrences(of: ",", with: ".")
        guard let doubleCurrentValue = Double(text) else { return text }
        let total = doubleCurrentValue / 100
        return NSNumber(value: total).stringValue
    }
    
    private func substract(value: String) -> String {
        guard let doubleValue = Double(value.replacingOccurrences(of: ",", with: "")), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: "")) else { return value }
        let total = doubleValue - doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    

    private func split(value: String) -> String {
        guard let doubleValue = Double(value.replacingOccurrences(of: ",", with: "")), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: "")) else { return value }
        let total = doubleValue / doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    private func multiply(value: String) -> String {
        guard let doubleValue = Double(value.replacingOccurrences(of: ",", with: "")), let doubleCurrentValue = Double(text.replacingOccurrences(of: ",", with: "")) else { return value }
        let total = doubleValue * doubleCurrentValue
        return NSNumber(value: total).stringValue
    }
    
    func formatNumberWithDots(_ number: String, toggleValueType: Bool = false) -> String {
        var formattedString = number
        if let doubleNumber = Double(number.replacingOccurrences(of: ",", with: "")), doubleNumber > 9999 || doubleNumber < 0{
            formattedString = doubleNumber.formatted(.number.notation(.automatic))
        }
        
        if toggleValueType {
            if text.contains("-") {
                return formattedString.replacingOccurrences(of: "-", with: "")
            } else {
                formattedString = "-\(formattedString)"
            }
        }
        return formattedString
    }
}


public struct ResultModel: Identifiable, Equatable {
    public let id = UUID()
    public var firstValue: String
    public let sign: String
    public var lastValue: String
    public var total: String
    
    init(result: String, lastResult: String, total: String, action: Action = .idle) {
        self.firstValue = result
        switch action {
        case .split:
           sign = "/"
        case .multiply:
            sign = "*"
        case .add:
            sign = "+"
        case .subtract:
            sign = "-"
        case .percentage:
            sign = "%"
        default: sign = ""
        }
        
        self.lastValue = lastResult
        self.total = total
    }
}
