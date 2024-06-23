//
//  uiTests.swift
//  uiTests
//
//  Created by Alex.personal on 18/6/24.
//

import XCTest

final class uiTests: XCTestCase {
    
    struct AccessibilityIdentifiers {
        static let reset = "AC"
        static let positiveAndNegative = "+/-"
        static let percentage = "%"
        static let divide = "➗"
        static let seven = "7"
        static let eight = "8"
        static let nine = "9"
        static let multiply = "X"
        static let four = "4"
        static let five = "5"
        static let six = "6"
        static let subtract = "-"
        static let one = "1"
        static let two = "2"
        static let three = "3"
        static let add = "+"
        static let zero = "0"
        static let decimal = "."
        static let equals = "="
        static let operationsAgenda = "operationAgendaTXT"
        static let resultText = "resultText"
    }
    
    override func setUpWithError() throws {
           continueAfterFailure = false
           let app = XCUIApplication()
           app.launch()
       }
    
    func testAddOperations() throws {
                
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists)
        let nineButton = app.buttons[AccessibilityIdentifiers.nine]
        let add = app.buttons[AccessibilityIdentifiers.add]
        let result = app.buttons[AccessibilityIdentifiers.equals]
        nineButton.tap()
        add.tap()
        nineButton.tap()
        result.tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.operationsAgenda].exists)
    }
    
    func testSubstractOperations() throws {
                
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists)
        let nineButton = app.buttons[AccessibilityIdentifiers.nine]
        let subsctract = app.buttons[AccessibilityIdentifiers.subtract]
        let result = app.buttons[AccessibilityIdentifiers.equals]
        nineButton.tap()
        subsctract.tap()
        nineButton.tap()
        result.tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.operationsAgenda].exists)
    }
    
    func testMultiplyOperations() throws {
                
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists)
        let nineButton = app.buttons[AccessibilityIdentifiers.nine]
        let multiply = app.buttons[AccessibilityIdentifiers.multiply]
        let result = app.buttons[AccessibilityIdentifiers.equals]
        nineButton.tap()
        multiply.tap()
        nineButton.tap()
        result.tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.operationsAgenda].exists)
    }
    
    func testDivideOperations() throws {
                
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists)
        let nineButton = app.buttons[AccessibilityIdentifiers.nine]
        let divide = app.buttons[AccessibilityIdentifiers.divide]
        let result = app.buttons[AccessibilityIdentifiers.equals]
        nineButton.tap()
        divide.tap()
        nineButton.tap()
        result.tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.operationsAgenda].exists)
    }
    
    func testPercentageOperations() throws {
                
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists)
        let nineButton = app.buttons[AccessibilityIdentifiers.nine]
        let percentage = app.buttons[AccessibilityIdentifiers.percentage]
        nineButton.tap()
        percentage.tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.operationsAgenda].exists)
    }
    
    func testAllButtonsExist() {
        let app = XCUIApplication()
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.reset].exists, "Reset button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.positiveAndNegative].exists, "Positive/Negative button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.percentage].exists, "Percentage button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.divide].exists, "Divide button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.seven].exists, "Button 7 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.eight].exists, "Button 8 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.nine].exists, "Button 9 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.multiply].exists, "Multiply button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.four].exists, "Button 4 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.five].exists, "Button 5 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.six].exists, "Button 6 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.subtract].exists, "Subtract button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.one].exists, "Button 1 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.two].exists, "Button 2 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.three].exists, "Button 3 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.add].exists, "Add button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.zero].exists, "Button 0 does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.decimal].exists, "Decimal button does not exist")
        XCTAssertTrue(app.buttons[AccessibilityIdentifiers.equals].exists, "Equals button does not exist")
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.resultText].exists, "result textField does not exist")
    }
}
