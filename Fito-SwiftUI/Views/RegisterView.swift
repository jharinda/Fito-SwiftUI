//
//  RegisterView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct RegisterView: View {
    var actionPerformed:((ProjectAction) -> Void)?
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @State var isLoggedIn = false
    @State var errorMessage = ""
    
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
                
                TextField("Name",text:$name).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                TextField("Age",text:$age).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                TextField("Height",text:$height).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle()).keyboardType(.numberPad)
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
                    .keyboardType(.emailAddress)
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                SecureField("Password",text:$password).font(.custom("Poppins-SemiBold", size: 15)).textFieldStyle(OvalTextFieldStyle())
                    .padding(.vertical,0)
                    .padding(.horizontal,40)
                
                HStack{
                    Text("Already have an account ?")
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { EmptyView() }
                    
                    NavigationLink(destination: LoginView().navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true), label: {
                            Text("Login").foregroundColor(Color.blue).onTapGesture {
                                
                                actionPerformed?(.login)
                            }
                        })
                }.padding(.vertical,20)
                Button(action: {
                    print("Register clicked")
                    register()
                }) {
                    
                    Text("Register").font(.custom("Poppins-SemiBold", size: 15)).padding(.horizontal,70)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(57)
                .offset(y:5)
                
                
                
                if(errorMessage != ""){
                    Text(errorMessage)
                        .padding(10)
                        .foregroundColor(.red).padding(.horizontal,30)
                        .background(.white)
                        .fontWeight(.bold)
                        .cornerRadius(60)
                        .offset(y:10)
                }
            }
        }
    }
    @State private var registrationStatus = ""
    func register(){
        
        let ageInt = Int(age)
        let heightFloat = Float(height)
        if(ageInt == nil){
            errorMessage = "Age should be a number"
        }
        
        if(heightFloat == nil){
            errorMessage = "Height should be a decimal"
        }
        
        if(name == ""){
            errorMessage = "Name is empty"
        } else if (age == ""){
            errorMessage = "Age is empty"
        }else if(height == ""){
            errorMessage = "Height is empty"
        }else if(gender == "Gender" || gender == ""){
            errorMessage = "Gender is empty"
        }else if(email == ""){
            errorMessage = "Email is empty"
        }else if(password == ""){
            errorMessage = "Password is empty"
        }else if(!isValidEmail(email)){
            errorMessage = "Not a valid email"
        }else if(password.count < 8){
            errorMessage = "Password length sound be more than 8"
        }
        
        if(errorMessage != ""){
            return;
        }
        
        let user = User(id: 0, name: name, password: password, email: email.lowercased(), age: ageInt!, heightInCm: heightFloat!, gender: gender)
        
        performRegistration(newUser: user)
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func performRegistration(newUser:User) {
        
        
        guard let url = URL(string: USER_API_URL) else {
            registrationStatus = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(newUser)
            request.httpBody = jsonData
        } catch {
            registrationStatus = "Encoding error: \(error)"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                registrationStatus = "Network error: \(error)"
                return
            }
            
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    
                    print(user)
                    loginAsync(email: newUser.email, password: newUser.password!)
                    
                } catch {
                    registrationStatus = "Decoding error: \(error)"
                }
            }
        }.resume()
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
                    
                    print(user)
                    print("user found")
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
