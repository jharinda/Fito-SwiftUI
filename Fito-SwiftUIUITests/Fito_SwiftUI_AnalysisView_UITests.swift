//
//  Fito_SwiftUI_AnalysisView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/24/23.
//
import XCTest
import SwiftUI
@testable import Fito_SwiftUI
//@testable import Model

final class Fito_SwiftUI_AnalysisView_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAnalysisViewUI() throws {
        app.tabBars.buttons["analyzeDataButton"].tap() // Tap the Analysis tab

        // Wait for AnalysisView to appear
        XCTAssertTrue(app.waitForExistence(timeout: 5))

        // Assert presence of Insights title
        XCTAssertTrue(app.staticTexts["Insights"].exists)

        // Assert presence of Weight distribution chart and its content
        XCTAssertTrue(app.staticTexts["Weight distribution"].exists)
        XCTAssertTrue(app.otherElements["WeightDistributionLabel"].exists)

        // Assert presence of Meal calories chart and its content
        XCTAssertTrue(app.staticTexts["Meal calories"].exists)
        XCTAssertTrue(app.otherElements["MealCaloriesLabel"].exists)

        // Assert presence of Workouts calories chart and its content
        XCTAssertTrue(app.staticTexts["Workouts calories"].exists)
        XCTAssertTrue(app.otherElements["WorkoutsCaloriesLabel"].exists)

    }

}
