//
//  Fito_SwiftUI_RegisterView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest

final class Fito_SwiftUI_RegisterView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testRegisterViewUI() throws {
            app.buttons["Get Started"].tap() // From The accessibility identifier "GetStartedButton"
            
            let nameTextField = app.textFields["NameTextField"]
            XCTAssertTrue(nameTextField.exists)
            nameTextField.tap()
            nameTextField.typeText("John Doe")

            let ageTextField = app.textFields["AgeTextField"]
            XCTAssertTrue(ageTextField.exists)
            ageTextField.tap()
            ageTextField.typeText("25")

            let heightTextField = app.textFields["HeightTextField"]
            XCTAssertTrue(heightTextField.exists)
            heightTextField.tap()
            heightTextField.typeText("175")

            app.pickerWheels.element.adjust(toPickerWheelValue: "Male")
            
            let emailTextField = app.textFields["EmailTextField"]
            XCTAssertTrue(emailTextField.exists)
            emailTextField.tap()
            emailTextField.typeText("john@example.com")

            let passwordSecureField = app.secureTextFields["PasswordSecureField"]
            XCTAssertTrue(passwordSecureField.exists)
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            app.buttons["Register"].tap() // check Register button => LoginView
            
            
     
    }

    override func tearDownWithError() throws {
        
    }

//    func testExample() throws {
//
//        let app = XCUIApplication()
//        app.launch()
//
//
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
