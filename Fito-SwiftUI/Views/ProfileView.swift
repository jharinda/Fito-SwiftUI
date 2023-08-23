//
//  ProfileView.swift
//  Fito-SwiftUI
//
//  Created by Roshel Rao on 2023-08-13.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    @State private var user: User?
    @State private var meal: Meal?
    
    @State private var meals: [Meal] = []
    @State private var workouts: [Workout] = []
            
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @State var isLoggedOut = false
    
    private var metrics : [String] = ["Kg","cm","Age","Weight"]
    
     private let colors: [Color] = [
     Color(red: 255/255, green: 208/255, blue: 208/255),
     Color(red: 255/255, green: 239/255, blue: 182/255),
     Color(red: 222/255, green: 255/255, blue: 226/255),
     Color(red: 206/255, green: 230/255, blue: 253/255)
     ]
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        VStack{
            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $isLoggedOut) { EmptyView() }
            ScrollView{
                HStack{
                    Text("Dashboard")
                        .font(.custom("Poppins-BoldItalic", size: 30))
                        .padding()
                    Image("logout").onTapGesture{
                        currentUserEmail = ""
                        isLoggedOut = true;
                    }.accessibilityIdentifier("LogoutButton")
                }
                HStack{
                    Spacer()
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 127,height: 127)
                        .clipShape(Circle())
                        .clipped()
                        .padding()
                    Spacer()
                }
                HStack{
                    if let user = user {
                        Text(user.name)
                            .font(.custom("Poppins-SemiBold", size: 30))
                        if(user.gender=="Male"){
                            Image("male").accessibilityIdentifier("GenderImageMale")
                        }else{
                            Image("female").accessibilityIdentifier("GenderImageFemale")
                        }
                    }else{
                        SpinnerView()
                    }
                    
                }
                if let user = user{
                    if(!user.records!.isEmpty){
                        let recordCount = user.records!.count - 1
                        let weight = user.records?[recordCount].weight
                        let bmiStatus = calBMIStatus(height:user.heightInCm,weight:weight!)
                        if(bmiStatus == "Overweight"){
                            Text("Overweight")
                                .font(.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(.red)
                                .accessibilityIdentifier("OverweightStatusLabel")
                        }else if(bmiStatus == "Underweight"){
                            Text("Underweight")
                                .font(.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(.red)
                                .accessibilityIdentifier("UnderweightStatusLabel")
                        }else if(bmiStatus == "Healthy"){
                            Text("Healthy")
                                .font(.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(.green)
                                .accessibilityIdentifier("HealthyStatusLabel")
                        }
                    }else{
                        Text("BMI Status not available")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .foregroundColor(.orange)
                    }
                }
                Spacer()
                LazyVGrid(columns: columns, spacing:20){
                    if let user = user{
                        if(!user.records!.isEmpty && !meals.isEmpty && !workouts.isEmpty){
                            let recordCount = user.records!.count - 1
                            let weight = user.records?[recordCount].weight
                            let weightStatus = predictWeightStatus(records: user.records!)
                            let data : [String] = ["\(weight!)", "\(user.heightInCm)", "\(user.age)", "\(weightStatus)"]
                            
                            ForEach(data,id:\.self){item in
                                ZStack{
                                    Rectangle()
                                        .frame(width:110,height: 110)
                                        .foregroundColor(colors[data.firstIndex(of: item) ?? 0])
                                        .cornerRadius(14)
                                        .shadow(
                                            color: Color.black.opacity(0.15),
                                            radius: 4,
                                            x: 4,
                                            y: 5
                                        ).accessibilityIdentifier("Metric\(index)View")
                                    VStack{
                                        Text("\(item)")
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                        Text("\(metrics[data.firstIndex(of: item) ?? 0])")
                                    }
                                }
                            }
                        }else if(user.records!.isEmpty){
                            let data : [String] = ["-", "\(user.heightInCm)", "\(user.age)", "."]
                            
                            ForEach(data,id:\.self){item in
                                ZStack{
                                    Rectangle()
                                        .frame(width:110,height: 110)
                                        .foregroundColor(colors[data.firstIndex(of: item) ?? 0])
                                        .cornerRadius(14)
                                        .shadow(
                                            color: Color.black.opacity(0.15),
                                            radius: 4,
                                            x: 4,
                                            y: 5
                                        )
                                    VStack{
                                        Text("\(item)")
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                        Text("\(metrics[data.firstIndex(of: item) ?? 0])")
                                    }
                                }
                            }
                        }else{
                            SpinnerView().offset(x:60)
                        }
                    }
                    
                }
                .padding(.top,10)
                .padding(.trailing,70)
                .padding(.leading,70)
            }
            .background(alignment: .topLeading) {
                Image("background")
                    .edgesIgnoringSafeArea(.all)
            }
        }.task {
            await getCurrentUserDetails()
            await getMeals()
            await getWorkouts()
            
        }
        
        
    }
    
    
    
    func getCurrentUserDetails() async{
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
    
    func calBMIStatus(height: Float,weight:Float) -> String{
        let BMIOverWeight : Float = 24.9;
        let BMIUnderWeight : Float = 18.5;
        
        let heightInM = height / 100;
        let bmi = weight / (heightInM * heightInM);
        
        if (bmi >= BMIOverWeight)
        {
            return "Overweight"
        }
        else if (bmi <= BMIUnderWeight)
        {
            return "Underweight"
        }
        else
        {
            return "Healthy"
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
    
    func predictWeightStatus(records:[Record]) -> String{
        var caloriesBurned = 0
        var calorieIntake = 0
        for record in records {
            for workoutRecord in record.recordWiseWorkouts{
                if let workout = workouts.first(where: { $0.id == workoutRecord.workoutId }) {
                            caloriesBurned = workout.kalCount * workoutRecord.reps
                        }
            }
            for mealRecord in record.recordWiseMeals{
                if let meal = meals.first(where: { $0.id == mealRecord.mealId }) {
                            calorieIntake = meal.kalCount * mealRecord.mealQuantity
                        }
                }
            }
        
        if(calorieIntake > caloriesBurned){
            return "G"
        }
        else{
            return "L"
        }
        
        }
}
    
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

    
