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

    func testAddRecordsViewUI() throws {
                        
        app.tabBars.buttons["addRecordButton"].tap()
        // Test DatePicker
        let datePicker = app.datePickers["DateDatePicker"]
        datePicker.tap()
        XCTAssertTrue(datePicker.exists)

        // Test Weight TextField
        let weightTextField = app.textFields["WeightTextField"]
        XCTAssertTrue(weightTextField.exists)
        weightTextField.tap()
        weightTextField.typeText("70")

        // Test Meal Menu
        let mealMenu = app.otherElements["MealMenu"]
        XCTAssertTrue(mealMenu.exists)
        mealMenu.tap()
        
        // Test Quantity TextField
        let quantityTextField = app.textFields["Quantity"]
        XCTAssertTrue(quantityTextField.exists)
        quantityTextField.tap()
        quantityTextField.typeText("2")

        // Test Add Meal Button
        let addMealButton = app.images["add"]
        XCTAssertTrue(addMealButton.exists)
        addMealButton.tap()
        
        
        // Test Workout Menu
        let workoutMenu = app.otherElements["WorkoutMenu"]
        XCTAssertTrue(workoutMenu.exists)
        workoutMenu.tap()
        
        
        // Test Reps TextField
        let repsTextField = app.textFields["Reps"]
        XCTAssertTrue(repsTextField.exists)
        repsTextField.tap()
        repsTextField.typeText("10")

        // Test Add Workout Button
        let addWorkoutButton = app.images["add"]
        XCTAssertTrue(addWorkoutButton.exists)
        addWorkoutButton.tap()
        
        
        // Test Submit Button
        let submitButton = app.buttons["SubmitButton"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()
       
        
        // Test Result Text
        let resultText = app.staticTexts.matching(identifier: "ResultText").firstMatch
        XCTAssertTrue(resultText.exists)
       
    }


    
}
