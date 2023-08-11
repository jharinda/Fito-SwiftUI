//
//  RegisterView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct RegisterView: View {
    var actionPerformed:((ProjectAction) -> Void)?
    @State var email = "";
    @State var password = "";
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
            VStack{
                Text("Register").font(.custom("Poppins-BoldItalic", size: 30)).offset(y:-40)
                
                TextField("Name",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                .padding(.vertical,0)
                .padding(.horizontal,40)
                
                TextField("Age",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                .padding(.vertical,0)
                .padding(.horizontal,40)
                
                TextField("Height",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                .padding(.vertical,0)
                .padding(.horizontal,40)
                
                TextField("Gender",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                .padding(.vertical,0)
                .padding(.horizontal,40)
                    
                    TextField("Email",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                TextField("Password",text:$password).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                HStack{
                    Text("Already have an account ?")
                    Text("Login").foregroundColor(Color.blue).onTapGesture {
                        
                        actionPerformed?(.login)
                    }
                    
                }.padding(.vertical,20)
                Button(action: {
                    print("Login clicked")
                   /* fetchData()*/
                }) {
                   
                    Text("Register").font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal,70)
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

