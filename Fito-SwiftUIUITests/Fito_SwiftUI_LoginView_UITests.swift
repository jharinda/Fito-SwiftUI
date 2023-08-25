//
//  Fito_SwiftUI_LoginView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//
import XCTest
import SwiftUI
@testable import Fito_SwiftUI
//@testable import Model

final class Fito_SwiftUI_LoginView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testLoginViewUI() throws {
            app.buttons["GetStartedButton"].tap()
            app.buttons["LoginButton"].tap()
            Thread.sleep(forTimeInterval: 5)
            let emailTextField = app.textFields["EmailTextField1"]
            XCTAssertTrue(emailTextField.exists)
            emailTextField.tap()
            emailTextField.typeText("john@example.com")

            let passwordSecureField = app.secureTextFields["PasswordSecureField1"]
            XCTAssertTrue(passwordSecureField.exists)
            passwordSecureField.tap()
            passwordSecureField.typeText("password123")

            // Tap the Login button
            app.buttons["LoginButton"].tap()

        }
    }

