//
//  LoginView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct LoginView: View {
    var actionPerformed:((ProjectAction) -> Void)?
    @State var email = "";
    @State var password = "";
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
            VStack{
                Text("Login").font(.custom("Poppins-BoldItalic", size: 30)).offset(y:-40)
                    
                    TextField("Email",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                TextField("Password",text:$password).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                HStack{
                    Text("Don't have an account ?")
                    Text("Register").foregroundColor(Color.blue).onTapGesture {
                        print("on tap register")
                        actionPerformed?(.register)
                    }
                    
                }.padding(.vertical,20)
                Button(action: {
                    print("Login clicked")
                   /* fetchData()*/
                }) {
                   
                    Text("Login").font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal,70)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(57)
                .offset(y:5)
                
            }
        }
    }
    
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .padding(.horizontal,10)
            .background()
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1),radius: 10,x: 4,y:5)
            
    }
}
