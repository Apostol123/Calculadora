// The Swift Programming Language
// https://docs.swift.org/swift-book
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
}


public final class Engine: ObservableObject {
    public  func observeEvent(_ event: Event) {
        currentEventValue = event.currentValue
        text.append(String(event.currentValue))
    }
    
    @Published public var currentEventValue: Int = 0
    @Published public var text: String = ""
    
    public init() {}
}

