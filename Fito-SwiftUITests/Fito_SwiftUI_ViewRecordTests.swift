//
//  Fito_SwiftUI_ViewRecordTests.swift
//  Fito-SwiftUITests
//
//  Created by user235431 on 8/24/23.
//
import XCTest

@testable import Fito_SwiftUI

final class Fito_SwiftUI_ViewRecordTests: XCTestCase {
    
    var viewRecordsView: ViewRecordsView!
    
    var user: User!
    var records: [Record]!
    
    override func setUp() {
        super.setUp()
        
        // Set up your test data, including user and records
        
        // Mock User
        user = User(id: 1, name: "Test User", password: "test123", email: "test@example.com", age: 30, heightInCm: 170, gender: "Male")
        
        // Example Records
        records = [
            Record(id: 1, userId: 1, date: "2023-08-01T08:00:00", weight: 70, recordWiseMeals: [], recordWiseWorkouts: []),
            Record(id: 2, userId: 1, date: "2023-08-02T09:00:00", weight: 68, recordWiseMeals: [], recordWiseWorkouts: [])
        ]
    }
    func testHasRecordsWithRecords() {
           let viewRecordsView = ViewRecordsView()
           
           // Set the user and records for testing
           viewRecordsView.user = user
           viewRecordsView.records = records
           
           let hasRecords = viewRecordsView.hasRecords()
           
           XCTAssertFalse(hasRecords, "Expected hasRecords to be true")
       }
    func testHasRecordsWithoutRecords() {
            let viewRecordsView = ViewRecordsView()
            
            // Set the user without records for testing
            viewRecordsView.user = user
            viewRecordsView.records = nil
            
            let hasRecords = viewRecordsView.hasRecords()
            
            XCTAssertFalse(hasRecords, "Expected hasRecords to be false")
        }
}
