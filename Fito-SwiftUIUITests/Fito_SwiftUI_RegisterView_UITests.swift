//
//  Fito_SwiftUI_RegisterView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest
import SwiftUI
@testable import Fito_SwiftUI

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
        
//        app.pickers["GenderPicker"].tap() // Tap to open the picker
//        sleep(1) // Wait for a second
//        app.pickerWheels.element.adjust(toPickerWheelValue: "Male") // Select the desired value
        
        let emailTextField = app.textFields["EmailTextField"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("john@example.com")
        
        let passwordSecureField = app.secureTextFields["PasswordSecureField"]
        XCTAssertTrue(passwordSecureField.exists)
        passwordSecureField.tap()
        passwordSecureField.typeText("password123")
        
        app.buttons["RegisterButton"].tap() // check Register button => LoginView
        
        
        
    }
    
    }
