//
//  Fito_SwiftUI_AddRecordsView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest

final class Fito_SwiftUI_AddRecordsView_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddRecordViewUI() throws {
        app.buttons["Get Started"].tap() // From The accessibility identifier "GetStartedButton"

        // Perform necessary actions to reach the AddRecordView

        // Test DatePicker
        let datePicker = app.datePickers["Date"]
        XCTAssertTrue(datePicker.exists)
        // Implement your interaction with the DatePicker
        
        // Test Weight TextField
        let weightTextField = app.textFields["Weight"]
        XCTAssertTrue(weightTextField.exists)
        weightTextField.tap()
        weightTextField.typeText("70")

        // Test Meal Menu
        let mealMenu = app.otherElements["MealMenu"]
        XCTAssertTrue(mealMenu.exists)
        mealMenu.tap()
        // Implement your interaction with the meal menu
        
        // Test Quantity TextField
        let quantityTextField = app.textFields["Quantity"]
        XCTAssertTrue(quantityTextField.exists)
        quantityTextField.tap()
        quantityTextField.typeText("2")

        // Test Add Meal Button
        let addMealButton = app.images["add"]
        XCTAssertTrue(addMealButton.exists)
        addMealButton.tap()
        // Implement your interaction with the Add Meal Button
        
        // Test Workout Menu
        let workoutMenu = app.otherElements["WorkoutMenu"]
        XCTAssertTrue(workoutMenu.exists)
        workoutMenu.tap()
        // Implement your interaction with the workout menu
        
        // Test Reps TextField
        let repsTextField = app.textFields["Reps"]
        XCTAssertTrue(repsTextField.exists)
        repsTextField.tap()
        repsTextField.typeText("10")

        // Test Add Workout Button
        let addWorkoutButton = app.images["add"]
        XCTAssertTrue(addWorkoutButton.exists)
        addWorkoutButton.tap()
        // Implement your interaction with the Add Workout Button
        
        // Test Submit Button
        let submitButton = app.buttons["Submit"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()
        // Implement your interaction with the Submit Button
        
        // Test Result Text
        let resultText = app.staticTexts.matching(identifier: "ResultText").firstMatch
        XCTAssertTrue(resultText.exists)
        // Implement your assertions for the result text
    }


    override func tearDownWithError() throws {

    }

//    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
