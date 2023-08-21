//
//  LoginView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct LoginView: View {
    var actionPerformed:((ProjectAction) -> Void)?
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @State var email = "";
    @State var password = "";
    @State var errorMessage = ""
    @State var isLoading = false
    
    @State var isLoggedIn = false
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
           
            VStack{
               
                Text("Login").font(.custom("Poppins-BoldItalic", size: 30)).offset(y:-40)
                
                TextField("Email",text:$email).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                SecureField("Password",text:$password).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                HStack{
                    Text("Don't have an account ? ")
                    NavigationLink(destination: RegisterView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true),
                                   label: {
                            Text("Register")
                            .foregroundColor(Color.blue)
                        })
                    
                }.padding(.vertical,20)
                Button(action: {
                    print("Login clicked")
                    login()
                }) {
                    
                    Text("Login").font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal,70)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(57)
                .offset(y:5)
                
                NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { EmptyView() }
                
                if(errorMessage != ""){
                    Text(errorMessage).padding(10).foregroundColor(.red).padding(.horizontal,30)
                        .background(.white).fontWeight(.bold).cornerRadius(60).offset(y:20)
                }
                
                if isLoading {
                    SpinnerView().offset(y:20)
                }
                
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
    
    func login(){
        errorMessage = ""
        
        let res = loginAsync(email: email.lowercased(), password: password)
        
    }
    
    func loginAsync(email:String, password:String) -> Bool{
        @AppStorage("currentUserId") var currentUserId = 0
        currentUserId = 0;
        var tempUser = User(id: 0, name: "", password:password, email: email, age: 0, heightInCm: 0, gender: "")
        var status = ""
        guard let url = URL(string: USER_API_URL + "/validate") else {
            status = "Invalid URL"
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(tempUser)
            request.httpBody = jsonData
        } catch {
            status = "Encoding error: \(error)"
            return false
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                status = "Network error: \(error)"
                return
            }
            
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    
                    currentUserId = user.id
                    currentUserEmail = user.email
                    isLoggedIn = true
                    actionPerformed?(.login)
                    print(user)
                    print("user found")
                    isLoading = false
                } catch {
                    status = "Decoding error: \(error)"
                    errorMessage = "Invalid Email or Password"
                    return ;
                }
            }else{
                errorMessage = "Invalid Email or Password"
            }
        }.resume()
        print("currentUserId " + String(currentUserId))
        if(currentUserId != 0){
            print("User was logged in")
            return true
        }
        
        print("User wasn't logged in")
        return false
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
