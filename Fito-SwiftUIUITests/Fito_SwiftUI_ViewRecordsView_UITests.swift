//
//  Fito_SwiftUI_ViewRecordsView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/24/23.
//

import XCTest
import SwiftUI
@testable import Fito_SwiftUI


final class Fito_SwiftUI_ViewRecordsView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            try super.setUpWithError()
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        override func tearDownWithError() throws {
            app = nil
            try super.tearDownWithError()
        }

        func testViewRecordsTab() throws {
            // Navigate to the View Records tab
            app.tabBars.buttons["viewRecordsButton"].tap()
            
            // Verify that the View Records tab is selected
            XCTAssertTrue(app.tabBars.buttons["viewRecordsButton"].isSelected)

            // Wait for the UI to load
            let list = app.tables.element(boundBy: 0)
            XCTAssertTrue(list.waitForExistence(timeout: 5), "View Records list did not appear")

            // Check if records are displayed
            if list.cells.count > 0 {
                // Tap on the first record
                list.cells.element(boundBy: 0).tap()

                // Verify that the details view is displayed
                XCTAssertTrue(app.navigationBars["Record Details"].exists)

                
            } else {
                // Verify that the "No records to show" text is displayed
                XCTAssertTrue(app.staticTexts["No records to show"].exists)
            }
        }
}
