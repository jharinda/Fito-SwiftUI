//
//  NetworkManager.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/12/23.
//

import SwiftUI
import Combine

class NetworkManager: ObservableObject {
   /* func sendPostRequest(body: RequestBody) {
        guard let url = URL(string: "https://your-api-url.com/endpoint") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            // Handle encoding error
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle network error
                    print("Network error: \(error)")
                }
            } receiveValue: { response in
                // Handle response data
                print("Response: \(response)")
            }
            .store(in: &cancellables) // Make sure to keep a reference to cancellables
    }*/
}

