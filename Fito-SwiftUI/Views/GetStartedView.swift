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
    @State private var size = 0.8;
    @State private var opacity = 0.5
    var actionPerformed:((ProjectAction) -> Void); //?
    var body: some View {
        ZStack{     Color.yellow.ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Fito")
                    .font(.custom("Poppins-BoldItalic", size: 40))
                    .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1.2)){
                                self.size = 1
                                self.opacity = 1
                            }
                        }
                Spacer()
                NavigationLink(destination: RegisterView().navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true), label: {
                        Text("Get Started").font(.custom("Poppins-SemiBold", size: 15))
                            .padding(.horizontal)
                            .frame(width: 200,height:50)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(60)
                            .accessibilityIdentifier("GetStartedButton") // Added accessibility identifier for UI testing
                    })
            }
            
        }
        
    }
}

