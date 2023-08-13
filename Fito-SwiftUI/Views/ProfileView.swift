//
//  ProfileView.swift
//  Fito-SwiftUI
//
//  Created by Roshel Rao on 2023-08-11.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    private var data : [String] = ["70", "170", "20", "W"]
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
            ScrollView{
                HStack{
                    Text("Dashboard")
                        .font(.custom("Poppins-BoldItalic", size: 40))
                        .padding()
                    Image("logout")
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
                    Text("David Costa")
                        .font(.custom("Poppins", size: 30))
                    Image("male")
                    
                }
                Text("Overweight")
                    .font(.custom("Poppins", size: 15))
                    .foregroundColor(.red)
                    .padding(5)
                Spacer()
                LazyVGrid(columns: columns, spacing:20){
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
                                    .font(.custom("Poppins", size: 20))
                                Text("\(metrics[data.firstIndex(of: item) ?? 0])")
                            }
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
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


