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
    public  func observeEvent(_ event: Event) {
        currentEventValue = event.currentValue
        switch event {
        case .value:
            text.append(String(event.currentValue))
        default:
            break
        }
       
        react(to: event.currentAction)
    }
    
    private func react(to action: Action) {
        switch action {
        case .reset:
            text = ""
        default:
            break
        }
    }
    
    @Published public var currentEventValue: Int = 0
    @Published public var text: String = ""
    
    public init() {}
}

