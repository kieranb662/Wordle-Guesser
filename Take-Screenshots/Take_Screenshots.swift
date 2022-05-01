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
        // MARK: - First Guess
        app.buttons["a"].tap()
//        snapshot("Letter-A-Tapped")
        app.buttons["Not In Word"].tap()
//        snapshot("Result-Tapped")
        app.buttons["e"].tap()
        snapshot("Letter E Tapped")
        app.buttons["Correct Position"].tap()
        snapshot("Correct Position Tapped")
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
        app.buttons["XMARK"].tap()
        // MARK: - Second Guess
        app.buttons["d"].tap()
        app.buttons["Not In Word"].tap()
        app.buttons["e"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["i"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["s"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["t"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["SUBMIT GUESS"].tap()
        // MARK: - Third Guess
        app.buttons["h"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["e"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["i"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["s"].tap()
        app.buttons["Correct Position"].tap()
        app.buttons["t"].tap()
        app.buttons["Correct Position"].tap()
        
        snapshot("Complete Game")
    }
}
