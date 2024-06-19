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
    
    func test_sut_correctlyParsesHundredThousandNumber() {
        // Given
        sut.observeEvent(.value("111111"))
        
        // Then
        XCTAssertEqual(sut.text, "111.111")
    }

    func test_sut_correctlyParsesMillionNumber() {
        // Given
        sut.observeEvent(.value("1111111"))
        
        // Then
        XCTAssertEqual(sut.text, "1.111.111")
    }

    func test_sut_correctlyParsesTensMillionNumber() {
        // Given
        sut.observeEvent(.value("11111111"))
        
        // Then
        XCTAssertEqual(sut.text, "11.111.111")
    }

    func test_sut_correctlyParsesHundredMillionNumber() {
        // Given
        sut.observeEvent(.value("111111111"))
        
        // Then
        XCTAssertEqual(sut.text, "111.111.111")
    }

    func test_sut_correctlyParsesThousandsNumber() {
        // Given
        sut.observeEvent(.value("11111"))
        
        // Then
        XCTAssertEqual(sut.text, "11.111")
    }
    
    func testAdd() {
        let randomNumbers = [111, 1314,1123,1314,1314,1313]
        
        for _ in 0..<10 {
            let value1 = randomNumbers.randomElement()!
            let value2 = randomNumbers.randomElement()!
            
            sut.observeEvent(.value(String(value1)))
            sut.observeEvent(.action(.add))
            sut.observeEvent(.value(String(value2)))
            sut.observeEvent(.action(.result))
            XCTAssertEqual(sut.text, String(value1+value2))
        }
    }
    
    func testMultiply() {
        let randomNumbers = [12, 13,10,7,6,12]
        
        for _ in 0..<10 {
            let value1 = randomNumbers.randomElement()!
            let value2 = randomNumbers.randomElement()!
            
            sut.observeEvent(.value(String(value1)))
            sut.observeEvent(.action(.multiply))
            sut.observeEvent(.value(String(value2)))
            sut.observeEvent(.action(.result))
            XCTAssertEqual(sut.text, String(value1*value2))
        }
    }
    
    func testSubstract() {
        let randomNumbers = [12, 13,10,7,6,12]
        
        for _ in 0..<10 {
            let value1 = randomNumbers.randomElement()!
            let value2 = randomNumbers.randomElement()!
            
            sut.observeEvent(.value(String(value1)))
            sut.observeEvent(.action(.subtract))
            sut.observeEvent(.value(String(value2)))
            sut.observeEvent(.action(.result))
            XCTAssertEqual(sut.text, String(value1-value2))
        }
    }
    
    func testSplit() {
        let randomNumbers = [12, 13,10,7,6,12]
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        
        for _ in 0..<10 {
            let value1 = randomNumbers.randomElement()!
            let value2 = randomNumbers.randomElement()!
            
            sut.observeEvent(.value(String(value1)))
            sut.observeEvent(.action(.split))
            sut.observeEvent(.value(String(value2)))
            sut.observeEvent(.action(.result))
            XCTAssertEqual(sut.text, formatter.string(from: NSNumber(value:Double(value1)/Double(value2))))
        }
    }
}
