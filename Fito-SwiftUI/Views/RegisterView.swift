//
//  RegisterView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct RegisterView: View {
    var actionPerformed:((ProjectAction) -> Void)?
    @State var name = "";
    @State var age = "";
    @State var height = "";
    @State var gender = "";
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
                
                /*TextField("Gender",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                .padding(.vertical,0)
                .padding(.horizontal,40)*/
                
                Picker("", selection: $gender, content: {
                    Text("Gender").tag("Option 1").foregroundColor(.black)
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                })
                .frame(width: 280)
                .pickerStyle(MenuPickerStyle())
                .padding(4)
                .padding(.horizontal,10)
                .background()
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1),radius: 10,x: 4,y:5)
                
                
                
              
                    
                    TextField("Email",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                SecureField("Password",text:$password).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                HStack{
                    Text("Already have an account ?")
                    NavigationLink(destination: LoginView().navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true), label: {
                            Text("Login").foregroundColor(Color.blue).onTapGesture {
                                
                                actionPerformed?(.login)
                            }
                        })
                }.padding(.vertical,20)
                Button(action: {
                    print("Login clicked")
                   register()
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
    
    func register(){
       // var user = User(id: 0, name: name, password: <#T##String#>, email: <#T##String#>, age: <#T##Int#>, heightInCm: <#T##Float#>)
    }
}

