//
//  User.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import Foundation

struct User:Decodable, Encodable,Hashable{
    var id:Int
    var name:String
    var password:String?
    var email:String
    var age:Int
    var heightInCm:Float
    var gender:String
    var records:[Record]?
}

struct Record:Decodable,Encodable,Hashable,Identifiable{
    var id:Int
    var userId:Int
    var date:String
    var weight:Float
    var recordWiseMeals:[RecordWiseMeal]
    var recordWiseWorkouts:[RecordWiseWorkout]
    
    func getMealCalories()-> Int {
        var calories = 0
       
        recordWiseMeals.forEach{ recordWiseMeal in
            mockMeals.forEach{meal in
                if(meal.id == recordWiseMeal.mealId){
                    calories += meal.kalCount
                }
            }
        }
        
        return calories
    }
    
    func getWorkoutCalories()-> Int {
        var calories = 0
       
        recordWiseWorkouts.forEach{ recordWiseWorkout in
            mockWorkouts.forEach{ workout in
                if(workout.id == recordWiseWorkout.workoutId){
                    calories += workout.kalCount
                }
            }
        }
        
        return calories
    }
}

struct RecordWiseMeal:Decodable,Encodable,Hashable{
    var id:Int
    var recordId:Int
    var mealId:Int
    var mealQuantity:Int
}

struct RecordWiseWorkout:Decodable,Encodable,Hashable{
    var id:Int
    var recordId:Int
    var workoutId:Int
    var reps:Int
}

struct Meal:Decodable,Encodable,Hashable{
    var id:Int
    var name:String
    var kalCount:Int
}

struct Workout:Decodable,Encodable,Hashable{
    var id:Int
    var name:String
    var kalCount:Int
}

struct MockDataProvider: Decodable,Encodable,Hashable {
    var mockMeals: [Meal]
    var mockWorkouts: [Workout]
}
