//
//  ViewRecordsView.swift
//  Fito-SwiftUI
//
//  Created by Roshel Rao on 2023-08-15.
//

import SwiftUI

struct ViewRecordsView: View {
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    
    @State private var user: User?
    
    @State private var result:Bool = false
    @State private var isPresented = false
    
    @State private var records: [Record]?
    
    @State private var backgroundColorList : Color = Color(red: 217/255, green: 217/255, blue: 217/255)

    
    var body: some View {
        VStack{
                HStack{
                    Text("Records")
                        .font(.custom("Poppins-BoldItalic", size: 40))
                        .padding()
                }
                
                HStack{
                    Spacer()
                        if(result){
                            if(user?.records != []){
                            List{
                                    ForEach(user?.records ?? [], id: \.self) { record in
                                        HStack{
                                            Text(record.date.components(separatedBy: "T").first ?? "")
                                                .font(.custom("Poppins", size: 15))
                                                .padding()
                                            
                                            Spacer()
                                            HStack{
                                                ZStack {
                                                    Text("Preview")
                                                    NavigationLink(destination:ViewRecordView(record: record)) {
                                                        EmptyView()
                                                    }.fixedSize()
                                                    .opacity(0)
                                                }
                                                
                                                Image("delete")
                                                    .padding(10)
                                                    .onTapGesture {
                                                        Task {
                                                            await deleteRecord(id: record.id)
                                                        }
                                                    }
                                            }
                                            
                                        }
                                        .listRowSeparator(.hidden)
                                        .listRowBackground(
                                            RoundedRectangle(cornerRadius:11)
                                                .background(.clear)
                                                .foregroundColor(backgroundColorList)
                                                .padding(
                                                    EdgeInsets(
                                                        top: 2,
                                                        leading: 16,
                                                        bottom: 2,
                                                        trailing: 16
                                                    )
                                                )
                                        )
                                    }
                                }.scrollContentBackground(.hidden)
                            }
                            else{
                                Text("No records to show")
                                    .font(.custom("Poppins-Regular", size: 20))
                            }

                        }
                    else{
                        SpinnerView()
                        
                    }
                    Spacer()
                }
                
                Spacer()
            
            }
            .background(alignment: .topLeading) {
                Image("background")
                    .edgesIgnoringSafeArea(.all)
            }
        
        .task {
            await getCurrentUserRecords()
            result = hasRecords()
        }
    }
    
    func deleteRecord(id:Int)async{
        print("Delete")
        guard let url = URL(string: USER_API_URL + "/Record/\(id)") else {fatalError("Missing URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do{
            try await URLSession.shared.dataTask(with: request)
            { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    print("Response Data: \(data)")
                }
            }.resume()
            
        await getCurrentUserRecords()
        }
    }
    
    func openModal(record:Record){
        isPresented = true
    }
    
    func getCurrentUserRecords() async{
        guard let url = URL(string: USER_API_URL + "/" + currentUserEmail) else { fatalError("Missing URL") }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                user = decodedUsers
            }
            
        }catch{
            print(error)
        }
    }
    
    func hasRecords() -> Bool{
        if(user?.records != nil){
            records = user?.records
            return true
        }else{
            return false
        }
    }
}

struct ViewRecordView: View {
    @State var record: Record
    
    @State private var meals: [Meal] = []
    @State private var workouts: [Workout] = []
    
    var body: some View {
        VStack{
            ScrollView(.vertical){
                Text("Date: \(record.date.components(separatedBy: "T").first ?? "")")
                    .font(.custom("Poppins", size: 20))
                    .padding()
                Text("Weight: \(record.weight, specifier: "%.2f")")
                    .font(.custom("Poppins", size: 20))
                    .padding()
                
                Text("Meals")
                    .font(.custom("Poppins", size: 20))
                    .padding()
                
                if(!meals.isEmpty && !workouts.isEmpty){
                    ForEach(record.recordWiseMeals, id: \.id) { mealwiseRecord in
                        if let matchedMeal = meals.first(where: { $0.id == mealwiseRecord.mealId }) {
                            VStack{
                                let calories = mealwiseRecord.mealQuantity * matchedMeal.kalCount
                                Text("Meal: \(matchedMeal.name)")
                                Text("Calories: \(calories)")
                            }.padding()
                        }
                    }
                    
                    
                    Text("Workouts")
                        .font(.custom("Poppins", size: 20))
                        .padding()
                    ForEach(record.recordWiseWorkouts, id: \.recordId) { workoutwiseRecord in
                        if let matchedWorkout = workouts.first(where: { $0.id == workoutwiseRecord.workoutId }) {
                            VStack{
                                let calories = workoutwiseRecord.reps * matchedWorkout.kalCount
                                Text("Workout: \(matchedWorkout.name)")
                                Text("Calories: \(calories)")
                            }.padding()
                        }
                    }
                    
                }else{
                    SpinnerView()
                        .padding()
                }
            }
            Spacer()
            
        }
        .scrollIndicators(.hidden)
        .task {
            await getMeals()
            await getWorkouts()
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
}


struct ViewRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecordsView()
    }
}
