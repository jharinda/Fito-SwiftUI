//
//  Fito_SwiftUI_GetStartedView_UITests.swift
//  Fito-SwiftUIUITests
//
//  Created by user235431 on 8/23/23.
//

import XCTest

final class Fito_SwiftUI_GetStartedView_UITests: XCTestCase {

    var app: XCUIApplication!

        override func setUpWithError() throws {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testGetStartedViewUI() throws {
        app.buttons["Get Started"].tap() // Get Started button => accessibility identifier "GetStartedButton"
            
            let fitoText = app.staticTexts["Fito"]
            XCTAssertTrue(fitoText.exists)
            
            let getStartedButton = app.buttons["GetStartedButton"]
            XCTAssertTrue(getStartedButton.exists)
            getStartedButton.tap()
            
            }
    

    override func tearDownWithError() throws {
        
    }

//    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//
//    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//                measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
