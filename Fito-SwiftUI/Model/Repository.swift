////
////  Repository.swift
////  Fito-SwiftUI
////
////  Created by user234937 on 8/12/23.
////
//
//import Foundation
//
//struct Repository{
//    var API_URL = ""
//    func loginUser(){
//        func sendPostRequest(body: User) {
//             guard let url = URL(string: API_URL) else {
//                 return
//             }
//             
//             var request = URLRequest(url: url)
//             request.httpMethod = "POST"
//             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//             
//             do {
//                 let jsonData = try JSONEncoder().encode(body)
//                 request.httpBody = jsonData
//             } catch {
//                 // Handle encoding error
//                 return
//             }
//             
//             URLSession.shared.dataTaskPublisher(for: request)
//                 .map(\.data)
//                 .decode(type: User.self, decoder: JSONDecoder())
//                 .receive(on: DispatchQueue.main)
//                 .sink { completion in
//                     switch completion {
//                     case .finished:
//                         break
//                     case .failure(let error):
//                         // Handle network error
//                         print("Network error: \(error)")
//                     }
//                 } receiveValue: { response in
//                     // Handle response data
//                     print("Response: \(response)")
//                 }
//                 .store(in: &cancellables) // Make sure to keep a reference to cancellables
//         }
//    }
//}
