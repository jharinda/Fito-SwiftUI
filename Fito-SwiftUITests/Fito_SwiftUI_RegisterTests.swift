////
//  Fito_SwiftUI_RegisterTests.swift
//  Fito-SwiftUITests
//
//  Created by user235431 on 8/24/23.
//

import XCTest
@testable import Fito_SwiftUI

class Fito_SwiftUI_RegisterTests: XCTestCase {
    //
    //    var registerView: RegisterView!
    
    func testRegister_Successful() {
        let registerView = RegisterView() // Initialize your RegisterView
        
        // Set valid registration data
        registerView.name = "John"
        registerView.age = "25"
        registerView.height = "175.5"
        registerView.gender = "Male"
        registerView.email = "john@example.com"
        registerView.password = "password123"
        
        // Mock a successful registration
        registerView.register()
        
        // Assuming registrationStatus is set to "Success" on successful registration
        XCTAssertEqual(registerView.registrationStatus, "Success")
        XCTAssertEqual(registerView.errorMessage, "") // Error message should be empty on success
    }
    func testRegister_InvalidAge() {
            let registerView = RegisterView() // Initialize your RegisterView
            
            // Set invalid age
            registerView.name = "John"
            registerView.age = "abc"
            registerView.height = "175.5"
            registerView.gender = "Male"
            registerView.email = "john@example.com"
            registerView.password = "password123"
            
            // Mock a registration with invalid age
            registerView.register()
            
            // Assuming errorMessage is set to "Age should be a number" for invalid age
            XCTAssertEqual(registerView.registrationStatus, "")
            XCTAssertEqual(registerView.errorMessage, "Age should be a number")
        }
    func testRegister_InvalidHeight() {
            let registerView = RegisterView() // Initialize your RegisterView
            
            // Set invalid height
            registerView.name = "John"
            registerView.age = "25"
            registerView.height = "abc"
            registerView.gender = "Male"
            registerView.email = "john@example.com"
            registerView.password = "password123"
            
            // Mock a registration with invalid height
            registerView.register()
            
            // Assuming errorMessage is set to "Height should be a decimal" for invalid height
            XCTAssertEqual(registerView.registrationStatus, "")
            XCTAssertEqual(registerView.errorMessage, "Height should be a decimal")
        }
}
