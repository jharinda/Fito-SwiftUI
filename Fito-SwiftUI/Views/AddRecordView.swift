//
//  AddRecordView.swift
//  Fito-SwiftUI
//
//  Created by Roshel Rao on 2023-08-16.
//

import SwiftUI

struct AddRecordView: View {
    
    @State var result = ""
    @State var date = Date()
    @AppStorage("weight") var weight = "";
    @AppStorage("quantity") var quantity = "";
    @AppStorage("reps") var reps = "";
    @State var record: Record?
    
    @AppStorage("mealValue") var mealValue = ""
    @AppStorage("workoutValue") var workoutValue = ""
    
    @State var selectedMeals : [String] = []
    @State var selectedWorkouts : [String] = []
    
    var placeholderMeals = "Meal"
    var placeholderWorkouts = "Workout"
    
    @State public var meals: [Meal] = []
    @State public var workouts: [Workout] = []
    
    @State public var recordWiseMeals: [RecordWiseMeal] = []
    @State public var recordWiseWorkouts: [RecordWiseWorkout] = []
    
    @AppStorage("currentUserId") var currentUserId = 0
    
    @State var isClicked : Bool = false
    @State private var showText = true

    @State private var textboxColor : Color = Color(red: 217/255, green: 217/255, blue: 217/255)
    @State private var textColor : Color = Color(red: 134 / 255, green: 134 / 255, blue: 134 / 255)
    
    var body: some View {
        
            VStack{
                if(!meals.isEmpty && !workouts.isEmpty){
                    ScrollView{
                        HStack{
                            Text("Record")
                                .font(.custom("Poppins-BoldItalic", size: 30))
                                .padding()
                        }
                        
                        VStack{
                            Spacer()
                            DatePicker("Date", selection: $date,displayedComponents: [.date])
                                .accessibilityIdentifier("DateDatePicker") // Added accessibility identifier
                                .font(.custom("Poppins-Regular", size: 15))
                                .foregroundColor(textColor)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(textboxColor)
                                .cornerRadius(20.0)
                                
                                                
                            
                            TextField("Weight",text:$weight).font(.custom("Poppins-SemiBold", size: 15))
                                .accessibilityIdentifier("WeightTextField") // Added accessibility identifier
                                                
                                .textFieldStyle(.plain)
                                .padding()
                                .background(textboxColor)
                                .cornerRadius(20.0)
                                .keyboardType(.decimalPad)
                            
                            HStack{
                                
                                Menu {
                                    
                                    ForEach(meals, id: \.self){ meal in
                                        Button(meal.name) {
                                            self.mealValue = meal.name
                                        }
                                    }
                                    
                                } label: {
                                    VStack(){
                                        HStack{
                                            Text(mealValue.isEmpty ? placeholderMeals : mealValue)
                                                .foregroundColor(mealValue.isEmpty ? .gray : .black)
                                                .font(.custom("Poppins-SemiBold", size: 15))
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color.gray)
                                                .font(Font.system(size: 20, weight: .bold))
                                        }
                                        .padding()
                                        .background(textboxColor)
                                        .cornerRadius(20.0)
//                                        .onChange(of: mealValue){ mealValue in
//                                            recordMeal = mealValue
//                                        }
                                    }.accessibilityIdentifier("MealMenu") // Added accessibility identifier

                                }
                                
                                TextField("Quantity",text:$quantity).font(.custom("Poppins-SemiBold", size: 15))
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(textboxColor)
                                    .cornerRadius(20.0)
                                    .keyboardType(.decimalPad)
                                    .frame(width: 100)
                                    .accessibilityIdentifier("Quantity") // Added accessibility identifier

                                Image("add")
                                    .onTapGesture {
                                        print("add meal")
                                        selectedMeals.append("\(quantity)" + " " + "\(mealValue)")
                                        var mealId = 0
                                        meals.forEach{ meal in
                                            if(meal.name == mealValue){
                                                mealId = meal.id
                                            }
                                        }
                                        recordWiseMeals.append(RecordWiseMeal(id: 0, recordId: 0, mealId: mealId, mealQuantity: Int(quantity) ?? 0))
                                        mealValue = ""
                                        quantity = ""
                                    
                                    }
                            }
                            HStack{
                                
                                Menu {
                                    ForEach(workouts, id: \.self){ workout in
                                        Button(workout.name) {
                                            self.workoutValue = workout.name
                                        }
                                    }
                                    
                                } label: {
                                    VStack(){
                                        HStack{
                                            Text(workoutValue.isEmpty ? placeholderWorkouts : workoutValue)
                                                .foregroundColor(workoutValue.isEmpty ? .gray : .black)
                                                .font(.custom("Poppins-SemiBold", size: 15))
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color.gray)
                                                .font(Font.system(size: 20, weight: .bold))
                                        }
                                        .padding()
                                        .background(textboxColor)
                                        .cornerRadius(20.0)
                                    }
                                }
                                
                                TextField("Reps",text:$reps).font(.custom("Poppins-SemiBold", size: 15))
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(textboxColor)
                                    .cornerRadius(20.0)
                                    .keyboardType(.decimalPad)
                                    .frame(width: 100)
                                    .accessibilityIdentifier("Reps") // Added accessibility identifier
                                
                                Image("add")
                                    .onTapGesture {
                                        selectedWorkouts.append("\(reps)" + " " + "\(workoutValue)")
                                        var workoutId = 0
                                        workouts.forEach{ workout in
                                            if(workout.name == workoutValue){
                                                workoutId = workout.id
                                            }
                                        }
                                        recordWiseWorkouts.append(RecordWiseWorkout(id: 0, recordId: 0, workoutId: workoutId, reps: Int(reps) ?? 0))
                                        workoutValue = ""
                                        reps = ""
                                        print("recordwise workouts - ", recordWiseWorkouts)
                                    }
                            }
                            HStack{
                                VStack(spacing:-40){
                                    Text("Workouts")
                                        .font(.custom("Poppins-SemiBold", size: 15))
                                        .foregroundColor(textColor)
                                        .padding(0)
                                    if(selectedWorkouts.count > 0){
                                        List{
                                            ForEach(selectedWorkouts,id: \.self) { workout in
                                                Text("\(workout)")
                                                    .listRowBackground(Color.clear)
                                                    .padding(0)
                                            }
                                        }
                                        .padding(.trailing,0)
                                        .scrollContentBackground(.hidden)
                                    }else{
                                        Rectangle().fill(Color.clear)
                                        
                                    }
                                }.padding()
                                    .background(textboxColor)
                                    .cornerRadius(20.0)
                                    .frame(height: 150)
                                
                                VStack(spacing:-40){
                                    Text("Meals")
                                        .font(.custom("Poppins-SemiBold", size: 15))
                                        .foregroundColor(textColor)
                                        .padding(0)
                                    if(selectedMeals.count > 0){
                                        List{
                                            ForEach(selectedMeals,id: \.self) { meal in
                                                Text("\(meal)")
                                                    .listRowBackground(Color.clear)
                                                    .padding(0)
                                            }
                                        }
                                        .padding(.trailing,0)
                                        .scrollContentBackground(.hidden)
                                        .scrollIndicators(.hidden)
                                    }else{
                                        Rectangle().fill(Color.clear)
                                        
                                    }
                                }.padding()
                                    .background(textboxColor)
                                    .cornerRadius(20.0)
                                    .frame(height: 150)
                            }
                                                        
                            Button(action: {
                                    result = addRecord()
                                    showText = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showText = false
                                    }
                            })
                            {
                                Text("Submit")
                                    .accessibilityIdentifier("SubmitButton") // Added accessibility identifier
                                                        
                                    .font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal,70)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(57)
                            .offset(y:15)
                            

                            if(result == "failed"){
                                Text("Failed to add record")
                                    .accessibilityIdentifier("ResultText") // Added accessibility identifier
                                                        
                                    .font(.custom("Poppins-SemiBold", size: 15))
                                    .padding()
                                    .foregroundColor(.red)
                                    .opacity(showText ? 1 : 0)
                            }else if(result == "success"){
                                Text("Record added!")
                                    .accessibilityIdentifier("ResultText") // Added accessibility identifier
                                                        
                                    .font(.custom("Poppins-SemiBold", size: 15))
                                    .padding()
                                    .foregroundColor(.green)
                                    .opacity(showText ? 1 : 0)
                            }
                         
                            Spacer()
                        }.padding()
                        
                        
                    }.padding()
                    .background(alignment: .topLeading) {
                        Image("background")
                            .edgesIgnoringSafeArea(.all)
                    }
                }else{
                    SpinnerView()
                }
            }
            .onTapGesture{
                hideKeyboard()
                
            }
            .task{
                async let workoutsTask = getWorkouts()
                async let mealsTask = getMeals()

                await workoutsTask
                await mealsTask
                
            }
        
    }
        
    func getMeals() async{
        guard let url = URL(string: "https://fitomealsapi.azurewebsites.net/api/Meals") else { fatalError("Missing URL") }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedMeals = try JSONDecoder().decode([Meal].self, from: data)
            DispatchQueue.main.async {
                meals = decodedMeals
            }
        }catch{
            print(error)
        }
    }
    
    func getWorkouts() async{
        guard let url = URL(string: "https://fitoworkoutsapi1.azurewebsites.net/api/Workouts") else { fatalError("Missing URL") }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedWorkouts = try JSONDecoder().decode([Workout].self, from: data)
            DispatchQueue.main.async {
                workouts = decodedWorkouts
            }
        }catch{
            print(error)
        }
    }
    
    func addRecord() -> String {
        var status = ""
        print(recordWiseMeals)
        print(recordWiseWorkouts)

        if(weight == "" || selectedMeals == [] || selectedWorkouts == [] ){
            return "failed"
        }else{
            let dateString = "\(date)"
            print("date - ",date)
            let dateOnly = dateString.split(separator: " ").first ?? ""
            let timeOnly = dateString.split(separator: " ")[1] ?? ""
            
            self.record = Record(id: 0, userId: currentUserId, date: dateOnly+"T"+timeOnly, weight: Float(weight) ?? 0, recordWiseMeals: recordWiseMeals, recordWiseWorkouts: recordWiseWorkouts)
            print("record - ",self.record)
            
            guard let url = URL(string: USER_API_URL + "/Record") else {
                status = "Invalid URL"
                return status
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONEncoder().encode(self.record)
                request.httpBody = jsonData
            } catch {
                status = "Encoding error: \(error)"
                return status
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    status = "Network error: \(error)"
                    return
                }
                
                if let data = data {
                    print(data)
                    do {
                        print("Success")
                    } catch {
                        status = "Decoding error: \(error)"
                        print(status)
                        return ;
                    }
                }else{
                    print("failed")
                }
            }.resume()
            clearData()
            return "success"
        }
        
    }
    
    func clearData(){
        weight = ""
        mealValue = ""
        quantity = ""
        workoutValue = ""
        reps = ""
        selectedMeals = []
        selectedWorkouts = []
        recordWiseMeals = []
        recordWiseWorkouts = []
    }
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}
