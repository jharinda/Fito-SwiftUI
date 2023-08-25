//
//  Fito_SwiftUI_ProfileView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest
import SwiftUI
@testable import Fito_SwiftUI

final class Fito_SwiftUI_ProfileView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

    func testProfileViewUI() throws {

        app.tabBars.buttons["viewProfileButton"].tap() // Tap the Profile tab
        // Wait for ProfileView to appear
        XCTAssertTrue(app.waitForExistence(timeout: 5))


        // Assert the presence of BMI status
        XCTAssertTrue(app.staticTexts["Overweight"].exists || app.staticTexts["Underweight"].exists || app.staticTexts["Healthy"].exists)

        // Assert the presence of the profile image
        XCTAssertTrue(app.images["profile"].exists)

        // Assert the presence of user name
        XCTAssertTrue(app.staticTexts["UserName"].exists)

        // Assert the presence of gender image
        XCTAssertTrue(app.images["GenderImage"].exists)

        // Scroll down to see more elements
        app.swipeUp()

        // Define the metric data array here
        let metricData = ["Weight", "cm", "Age", "Weight Status"]

        for (_, metric) in metricData.enumerated() {
            XCTAssertTrue(app.otherElements["\(metric)Metric"].exists, "\(metric) metric view exists")
        }
        // Scroll down again to see more elements
        app.swipeUp()
        

        // Assert that the specific action or navigation has occurred
        XCTAssertTrue(app.navigationBars["WeightMetricDetailView"].exists)
        // Tap the logout image
        app.images["logout"].tap()
        
        // Wait for LoginView to appear
        XCTAssertTrue(app.waitForExistence(timeout: 5))
    }


}
