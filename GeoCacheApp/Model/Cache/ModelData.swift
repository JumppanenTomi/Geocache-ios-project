//
//  ModelData.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import Foundation
import Combine

final class ModelData: ObservableObject{
    @Published var caches: [Cache] = []
    
    static func getGeocaches(completion: @escaping (Result<[Cache], Error>) -> Void) {
        guard let url = URL(string: "https://gocache-api.herokuapp.com/api/caches/?include=users") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let headers = [
            "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjA4Mzh9.dC5cFdXHQN_sIs1fBmuIuXngp-qYSyzqcH4recUCdiE",
            "Accept": "application/json"
        ]
        request.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                print(data)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([Cache].self, from: data)
                completion(.success(response))
                
                } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
