//
//  AnalysisView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/15/23.
//

import SwiftUI
import Charts

struct AnalysisView: View {
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @State var user : User?
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    Text("Insights")
                        .font(.custom("Poppins-BoldItalic", size: 30))
                        .padding()
                }
                
                Spacer()
                
                VStack{
                    
                    if user != nil {
                        
                        Text("Weight distribution")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .padding(.vertical,10)
                        Chart{
                            if(user?.records?.count ?? 0 > 0){
                                ForEach((user?.records)!){ record in
                                    LineMark(
                                        x: .value("Date", record.date),
                                        y: .value("Weight", record.weight)
                                    )
                                    .foregroundStyle(Color.blue.gradient).cornerRadius(10)
                                }
                                
                            }
                        }.frame(height: 180)
                        
                        Text("Meal calories")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .padding(.vertical,10)
                        
                        Chart{
                            if(user?.records?.count ?? 0 > 0){
                                //RuleMark(y:.value("Goal", 500))
                                
                                ForEach((user?.records)!){ record in
                                    BarMark(
                                        x: .value("Date", record.date),
                                        y: .value("Meal", record.getMealCalories())
                                    )
                                    .foregroundStyle(Color.orange.gradient).cornerRadius(10)
                                }
                                
                            }
                        }.frame(height: 180)
                        
                        Text("Workouts calories")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .padding(.vertical,10)
                        
                        Chart{
                            if(user?.records?.count ?? 0 > 0){
                                ForEach((user?.records)!){ record in
                                    BarMark(
                                        
                                        x: .value("Date", record.date),
                                        y: .value("Workouts", record.getWorkoutCalories())
                                    )
                                    .foregroundStyle(Color.pink.gradient).cornerRadius(10)
                                }
                                
                            }
                        }.frame(height: 180)
                    } else{
                        SpinnerView().offset(y:20)
                    }
                }.padding(.horizontal,40)
                
                
            }
            .background(alignment: .topLeading) {
                Image("background")
                    .edgesIgnoringSafeArea(.all)
            }

        }.task{
            await getCurrentUserDetails()
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
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
