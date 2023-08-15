//
//  AddRecordView.swift
//  Fito-SwiftUI
//
//  Created by user235431 on 8/14/23.
//

import SwiftUI

struct AddRecordView: View {
    @State private var date = Date()
    @State private var selectedMealId: Int?
    @State private var mealQuantity = 0
    @State private var selectedWorkoutId: Int?
    @State private var reps = 0
    @State private var mealIdsAdded: [Int] = []
    @State private var workoutIdsAdded: [Int] = []
    @State private var meals: [Meal] = []
    @State private var workouts: [Workout] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Record")
                    .font(.custom("Poppins-BoldItalic", size: 30))
                    .offset(y: -40)
                
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    .font(.custom("Poppins-SemiBold", size: 15))
                
                VStack(alignment: .leading) {
                    Text("Select Meal")
                    Picker("Select Meal", selection: $selectedMealId) {
                        ForEach(meals, id: \.id) { meal in
                            Text(meal.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .font(.custom("Poppins-SemiBold", size: 15))
                }
                TextField("Meal Quantity", value: $mealQuantity, format: .number)
                    .font(.custom("Poppins-SemiBold", size: 15))
                    .textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical, 0)
                    .padding(.horizontal, 40)
                Button("Add Meal") {
                    addMeal()
                }
                
                Picker("Select Workout", selection: $selectedWorkoutId) {
                    ForEach(workouts, id: \.id) { workout in
                        Text(workout.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.custom("Poppins-SemiBold", size: 15))
                TextField("Reps", value: $reps, format: .number)
                    .font(.custom("Poppins-SemiBold", size: 15))
                    .textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical, 0)
                    .padding(.horizontal, 40)
                Button("Add Workout") {
                    addWorkout()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Added Workouts:")
                        .font(.custom("Poppins-SemiBold", size: 15))
                    ForEach(workoutIdsAdded, id: \.self) { workoutId in
                        Text("\(workoutId)")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Added Meals:")
                        .font(.custom("Poppins-SemiBold", size: 15))
                    ForEach(mealIdsAdded, id: \.self) { mealId in
                        Text("\(mealId)")
                    }
                }
                
//               Button("Submit") {
//                   submitRecord()
//               }
//                .font(.custom("Poppins-SemiBold", size: 15))
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Add Record")
    }
    
    private func addMeal() {
        if let mealId = selectedMealId {
            mealIdsAdded.append(mealId)
            selectedMealId = nil
            mealQuantity = 0
        }
    }
    
    private func addWorkout() {
        if let workoutId = selectedWorkoutId {
            workoutIdsAdded.append(workoutId)
            selectedWorkoutId = nil
            reps = 0
        }
    }
    
    
    private func submitRecord() {
        let recordWiseMeals = mealIdsAdded.map { mealId in
            RecordWiseMeal(id: 0, recordId: 0, mealId: mealId, mealQuantity: mealQuantity)
        }
        
        let recordWiseWorkouts = workoutIdsAdded.map { workoutId in
            RecordWiseWorkout(id: 0, recordId: 0, workoutId: workoutId, reps: reps)
        }
        
        let record = Record(
            id: 0,
            userId: 0,
            date: "Date String", // Convert Date to String if needed
            weight: 0,
            recordWiseMeals: recordWiseMeals,
            recordWiseWorkouts: recordWiseWorkouts
        )
        
        guard let url = URL(string: "https://fitoworkoutsapi1.azurewebsites.net/api/Workouts") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(record)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        print("Record submitted successfully!")
                        // Handle success, show an alert, etc.
                    } else {
                        print("HTTP Status Code: \(response.statusCode)")
                        // Handle error, show an alert, etc.
                    }
                }
            }.resume()
            
        } catch {
            print("Encoding error: \(error.localizedDescription)")
        }
    }
    
    private func fetchMeals() {
        guard let url = URL(string: "https://fitomealsapi.azurewebsites.net/api/Meals") else {
            print("Invalid URL for Meals")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching Meals: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let mealsResponse = try JSONDecoder().decode([Meal].self, from: data)
                    DispatchQueue.main.async {
                        meals = mealsResponse
                    }
                } catch {
                    print("Error decoding Meals data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    private func fetchWorkouts() {
        guard let url = URL(string: "https://fitoworkoutsapi.azurewebsites.net/api/Workouts") else {
            print("Invalid URL for Workouts")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching Workouts: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let workoutsResponse = try JSONDecoder().decode([Workout].self, from: data)
                    DispatchQueue.main.async {
                        workouts = workoutsResponse
                    }
                } catch {
                    print("Error decoding Workouts data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }}
    
    struct AddRecordView_Previews: PreviewProvider {
        static var previews: some View {
            AddRecordView()
        }
    }

