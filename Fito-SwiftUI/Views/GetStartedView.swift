//
//  GetStartedView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI
enum ProjectAction{
    case login
    case getStarted
    case register
    case dashboard
}

struct GetStartedView: View {
    var actionPerformed:((ProjectAction) -> Void); //?
    var body: some View {
        ZStack{     Color.yellow.ignoresSafeArea()
            VStack{
                Spacer()
                Text("Fito")
                    .font(.custom("Poppins-BoldItalic", size: 40))
                Spacer()
                Button(action: {
                    actionPerformed(.login)
                }) {
                   
                    Text("Get Stareted").font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(57)
                .offset(y:-50)
                
            }
            
        }
       
    }
}

