//
//  Fito_SwiftUI_AddRecordTests.swift
//  Fito-SwiftUITests
//
//  Created by user235431 on 8/24/23.
//

import XCTest
@testable import Fito_SwiftUI

final class Fito_SwiftUI_AddRecordTests: XCTestCase {
    
    var addRecordView: AddRecordView!
    
    func testAddRecord_InValidData() {
        let addRecordView = AddRecordView()
        
        // Set valid data
        addRecordView.weight = "70"
        addRecordView.mealValue = "Carrot"
        addRecordView.quantity = "1a"
        addRecordView.workoutValue = "Pushup"
        addRecordView.reps = "10"
        
        let result = addRecordView.addRecord()
        
        XCTAssertEqual(result, "failed")
    }
    func testAddRecord_MissingData() {
            let addRecordView = AddRecordView()
            
            // Missing weight, meal, and workout
            let result = addRecordView.addRecord()
            
            XCTAssertEqual(result, "failed")
        }
        
        func testAddRecord_InvalidWeight() {
            let addRecordView = AddRecordView()
            
            // Invalid weight
            addRecordView.weight = "abc"
            addRecordView.mealValue = "Carrot"
            addRecordView.quantity = "1"
            addRecordView.workoutValue = "Pushup"
            addRecordView.reps = "10"
            
            let result = addRecordView.addRecord()
            
            XCTAssertEqual(result, "failed")
        }
}
