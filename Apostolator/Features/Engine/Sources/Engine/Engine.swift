// The Swift Programming Language
// https://docs.swift.org/swift-book

public enum Event {
    case value(Int)
    case action(Action)
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


public final class Engine {
    public static func observeEvent(_ event: Event) {
        print(event)
    }
}

