//
//  Fito_SwiftUI_GetStartedView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//


import XCTest

@testable import Fito_SwiftUI

class Fito_SwiftUI_GetStartedView_UITests: XCTestCase {
        
        var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testGetStartedButtonTapped() {
            // Tap the "Get Started" button
            app.buttons["GetStartedButton"].tap()
            
            
        }
}
