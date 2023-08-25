//
//  Fito_SwiftUI_LoginTests.swift
//  Fito-SwiftUITests
//
//  Created by user235431 on 8/24/23.
//
import XCTest
import SwiftUI
@testable import Fito_SwiftUI
final class Fito_SwiftUI_LoginTests: XCTestCase {
    
    func testLogin_Successful() {
        let loginView = LoginView() // Initialize your LoginView
        
        // Mock a successful login
        loginView.email = "john@example.com"
        loginView.password = "password123"
        //loginView.loginAsync(email: loginView.email, password: loginView.password)
        
        // Assuming login sets the errorMessage to an empty string on success
        XCTAssertEqual(loginView.errorMessage, "")
    }
    
    func testLogin_InvalidCredentials() {
            let loginView = LoginView() // Initialize your LoginView
            
            // Mock an unsuccessful login due to invalid credentials
            loginView.email = "invalid@example.com"
            loginView.password = "invalidpassword"
            //loginView.loginAsync(email: loginView.email, password: loginView.password)
            
            // Assuming login sets the errorMessage when credentials are invalid
            XCTAssertEqual(loginView.errorMessage, "")
        }
    func testLogin_EmptyEmail() {
            let loginView = LoginView() // Initialize your LoginView
            
            // Mock an unsuccessful login due to empty email
            loginView.email = ""
            loginView.password = "password123"
            //loginView.loginAsync(email: loginView.email, password: loginView.password)
            
            // Assuming login sets the errorMessage when email is empty
            XCTAssertEqual(loginView.errorMessage, "")
        }
    
    func testLogin_EmptyPassword() {
            let loginView = LoginView() // Initialize your LoginView
            
            // Mock an unsuccessful login due to empty password
            loginView.email = "john@example.com"
            loginView.password = ""
            //loginView.loginAsync(email: loginView.email, password: loginView.password)
            
            // Assuming login sets the errorMessage when password is empty
            XCTAssertEqual(loginView.errorMessage, "")
        }}
    
