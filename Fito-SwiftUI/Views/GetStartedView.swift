//
//  GetStartedView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        ZStack{     Color.yellow.ignoresSafeArea()
            VStack{
                Spacer()
                Text("Fito")
                    .font(.custom("Poppins-BoldItalic", size: 40))
                Spacer()
                Button(action: {}) {
                   
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

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
