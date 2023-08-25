//
//  Fito_SwiftUI_TabBarView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/24/23.

import XCTest
@testable import Fito_SwiftUI

final class Fito_SwiftUI_TabBarView_UITests: XCTestCase {
     var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testTabSelection() throws {
            
            // Select the Add Record tab
            app.buttons["addRecordButton"].tap()

            // Check that the Add Record view is displayed
            XCTAssertTrue(app.otherElements["AddRecordView"].exists)

            // Select the View Records tab
            app.buttons["viewRecordsButton"].tap()

            // Check that the View Records view is displayed
            XCTAssertTrue(app.otherElements["ViewRecordsView"].exists)

            // Select the Analysis tab
            app.buttons["analyzeDataButton"].tap()

            // Check that the Analysis view is displayed
            XCTAssertTrue(app.otherElements["AnalysisView"].exists)
            // Select the Profile tab
            app.buttons["viewProfileButton"].tap()

            // Check that the Profile view is displayed
            XCTAssertTrue(app.otherElements["ProfileView"].exists)
        }
    
    func testViewRecordsTabAccessibility() throws {
        let tabBar = app.tabBars["Tab Bar"]
        let viewRecordsButton = tabBar.buttons["viewRecordsButton"]
        //XCTAssertTrue(viewRecordsButton.exists)

        viewRecordsButton.tap()

        let viewRecordsLabel = app.staticTexts["View Records"]
        XCTAssertTrue(viewRecordsLabel.exists)
    }
}
