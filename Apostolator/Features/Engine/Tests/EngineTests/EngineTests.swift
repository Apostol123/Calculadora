import XCTest
@testable import Engine

final class EngineTests: XCTestCase {
    var sut: Engine!
    
    override func setUp() {
        sut = Engine()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_sut_given_ValueEvent_then_executes_right_Event() {
        // Given
        let value = "a"
        
        // When
        sut.observeEvent(.value(value))
        
        // Then
        XCTAssertEqual(sut.text, value)
    }
    
    func test_sut_given_ActionEvent_then_executes_right_Event() {
        // Given
        let action = Action.add
        
        // When
        sut.observeEvent(.action(action))
        
        // Then
        XCTAssertEqual(sut.currentAction, action)
    }
    
    func test_sut_given_two_values_and_Action_then_has_correct_values() {
        // Given
        let value = "1"
        let value2 = "2"
        let action = Action.add
        
        // When
        sut.observeEvent(.value(value))
        sut.observeEvent(.action(action))
        sut.observeEvent(.value(value2))
        
        
        // Then
        XCTAssertEqual(sut.text, value2)
        XCTAssertEqual(sut.lastText, value)
    }
    
    func test_sut_max_string_size() {
        // Given
        var number = "111.111.111"
        
        // When
        sut.observeEvent(.value(number))
        
        // Then
        XCTAssertEqual(sut.text.count, 11)
        
        number.append("11")
        
        sut.observeEvent(.value(number))
        
        XCTAssertEqual(sut.text.count, 11)
    }
}
