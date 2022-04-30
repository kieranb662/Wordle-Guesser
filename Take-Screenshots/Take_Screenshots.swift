// Swift toolchain version 5.0
// Running macOS version 12.3
// Created on 4/30/22.
//
// Author: Kieran Brown
//

import XCTest
import UIKit
import SwiftUIComponents

class Take_Screenshots: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func test_Snapshots_Recordings() {
        snapshot("Empty-State")
        app.buttons["a"].tap()
        snapshot("Letter-A-Tapped")
        app.buttons["Not In Word"].tap()
        app.buttons["e"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["r"].tap()
        app.buttons["Not In Word"].tap()
        app.buttons["o"].tap()
        app.buttons["Not In Word"].tap()
        app.buttons["s"].tap()
        app.buttons["Wrong Position"].tap()
        snapshot("First-Guess-Not-Submitted")
        app.buttons["SUBMIT GUESS"].tap()
        snapshot("Guess-Submitted")
        app.buttons["33 possible words"].tap()
        app.tables.cells["b, 1 WORD"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        snapshot("Possible-Word-List")
    }
    
    func tap(_ buttonText: String) {
        app.buttons[buttonText].tap()
    }
    
    //
    //    func test_Take_Screenshots() {
    //        snapshot("Empty-State")
    //        tap("a")
    //        snapshot("Letter-A-Tapped")
    //        tap("Not In Word")
    //        tap("e")
    //        tap("Correct Position")
    //        tap("r")
    //        tap("Not In Word")
    //        tap("o")
    //        tap("Not In Word")
    //        tap("s")
    //        tap("Wrong Position")
    //        snapshot("First Guess Not Submitted")
    //        tap("Submit Guess")
    //        snapshot("Guess Submitted")
    //        tap("33 possible words")
    //        tap("a")
    //        snapshot("Possible Word List")
    //    }
}
