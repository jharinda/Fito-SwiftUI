////
////  Fito_SwiftUI_ProfileTests.swift
////  Fito-SwiftUITests
////
////  Created by user235431 on 8/24/23.
////
import XCTest

@testable import Fito_SwiftUI

final class Fito_SwiftUI_ProfileTests: XCTestCase {
         var profileView: ProfileView!
    var user:User!

        override func setUp() {
            super.setUp()
            profileView = ProfileView()
        }

        override func tearDown() {
            profileView = nil
            super.tearDown()
        }

        // Test the calBMIStatus function
        func testCalBMIStatus_Healthy() {
            let status = profileView.calBMIStatus(height: 160, weight: 55)
            XCTAssertEqual(status, "Healthy")
        }

        func testCalBMIStatus_Overweight() {
            let status = profileView.calBMIStatus(height: 160, weight: 70)
            XCTAssertEqual(status, "Overweight")
        }

        func testCalBMIStatus_Underweight() {
            let status = profileView.calBMIStatus(height: 160, weight: 45)
            XCTAssertEqual(status, "Underweight")
        }
    
        let mockMeals: [Meal] = [
           Meal(id: 1, name: "Carrot", kalCount: 100),
           Meal(id: 2, name: "Rice", kalCount: 500),
           Meal(id: 3, name: "Bun", kalCount: 300)
       ]
       
       let mockWorkouts: [Workout] = [
           Workout(id: 1, name: "Pushup", kalCount: 100),
           Workout(id: 2, name: "Situp", kalCount: 500),
           Workout(id: 3, name: "Pullup", kalCount: 300)
       ]
       func testPredictWeightStatus_GreaterIntake() {
           // Create a mock record with greater calorie intake than burned
           let record = Record(id: 3, userId: 3, date: "2023-08-19", weight: 70,
                                recordWiseMeals: [RecordWiseMeal(id: 3, recordId: 20, mealId: 3, mealQuantity: 100)],
                                recordWiseWorkouts: [RecordWiseWorkout(id: 1, recordId: 1, workoutId: 1, reps: 1)])
           
           // Calculate the weight status
           let weightStatus = profileView.predictWeightStatus(records: [record])

           XCTAssertEqual(weightStatus, "L")
       }

       func testPredictWeightStatus_LowerIntake() {
           // Create a mock record with lower calorie intake than burned
           let record = Record(id: 2, userId: 1, date: "2023-08-19", weight: 70,
                                recordWiseMeals: [RecordWiseMeal(id: 1, recordId: 1, mealId: 1, mealQuantity: 1)],
                                recordWiseWorkouts: [RecordWiseWorkout(id: 1, recordId: 1, workoutId: 1, reps: 5)])

           // Calculate the weight status
           let weightStatus = profileView.predictWeightStatus(records: [record])

           XCTAssertEqual(weightStatus, "L")
       }




}
