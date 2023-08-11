//
//  User.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import Foundation

struct User{
    var id:any Identifiable
    var name:String
    var password:String
    var email:String
    var age:Int
    var heightInCm:Float
    var records:[Record]
}

struct Record{
    var id:Int
    var userId:Int
    var date:Date
    var weight:Float
    var recordWiseMeals:[RecordWiseMeal]
    var recordWiseWorkout:[RecordWiseWorkout]
}

struct RecordWiseMeal{
    var id:any Identifiable
    var recordId:Int
    var mealId:Int
    var mealQuantity:Int
}

struct RecordWiseWorkout{
    var id:any Identifiable
    var recordId:Int
    var workoutId:Int
    var reps:Int
}

struct Meal{
    var id:Int
    var name:String
    var kalCount:Int
}
