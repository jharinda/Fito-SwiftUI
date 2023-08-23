//
//  Fito_SwiftUI_ProfileView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest

final class Fito_SwiftUI_ProfileView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }
    
    func testProfileViewUI() throws {
        app.buttons["Login"].tap() // Tap the Login button to navigate to ProfileView
        
        // Wait for ProfileView to appear
        XCTAssertTrue(app.waitForExistence(timeout: 5))
        
        // Perform assertions and interactions
        
        // Tap the logout image
        app.images["logout"].tap()
        
        // Wait for LoginView to appear
        XCTAssertTrue(app.waitForExistence(timeout: 5))
        
        // Assert presence of specific metrics
        XCTAssertTrue(app.otherElements["WeightMetric"].exists)
        XCTAssertTrue(app.otherElements["cmMetric"].exists)
        XCTAssertTrue(app.otherElements["AgeMetric"].exists)
        XCTAssertTrue(app.otherElements["WeightStatusMetric"].exists)
        
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
        
        // Assert presence of additional LazyVGrid elements (if any)
        XCTAssertTrue(app.otherElements["Metric4"].exists)
        XCTAssertTrue(app.otherElements["Metric5"].exists)
        
        // Tap on a specific metric to perform an action (if applicable)
        app.otherElements["WeightMetric"].tap()
        
        // Assert that the specific action or navigation has occurred
        XCTAssertTrue(app.navigationBars["WeightMetricDetailView"].exists)
        
        // Add more assertions as needed
        
    }
    
    override func tearDownWithError() throws {
    }

//    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
//}

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
                measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
