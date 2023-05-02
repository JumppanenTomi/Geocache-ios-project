//
//  ModelData.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import Foundation
import SwiftUI
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
    
    
    func addCache(name: String, desc: String, dif: Int, size: Int, hint: String, userID: Int = 1, latitude: Double, longitude: Double) {
        let url = URL(string: "https://gocache-api.herokuapp.com/api/caches/")!
        let body: [String: Any] = [
            "name": name,
            "description": desc,
            "difficulty": dif,
            "size": size,
            "hint": hint,
            "userID": userID,
            "latitude": latitude,
            "longitude": longitude
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjA4Mzh9.dC5cFdXHQN_sIs1fBmuIuXngp-qYSyzqcH4recUCdiE", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Error: No data received")
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }

    
    
    func foundCache(cacheId: Int) {
                let url = URL(string: "https://gocache-api.herokuapp.com/api/logs")!
                // Create the request
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                // Set the request headers
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjA4Mzh9.dC5cFdXHQN_sIs1fBmuIuXngp-qYSyzqcH4recUCdiE", forHTTPHeaderField: "Authorization")
                
                // Create the request body
                let requestBody: [String: Any] = ["logType": "found","logComment": "Cache found","userID": 1,"cacheID": cacheId]
                
                // Serialize the request body to JSON
                let jsonData = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
                
                // Set the request body
                request.httpBody = jsonData
                
                // Send the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // Handle the response
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    guard let data = data else {
                        print("No data returned from server")
                        return
                    }
                    print(String(data: data, encoding: .utf8)!)
                }.resume()
    }
    
    func deleteLog(userId: Int, cacheId: Int) {
        guard let url = URL(string: "https://gocache-api.herokuapp.com/api/logs/") else {
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
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let logs = try decoder.decode([Log].self, from: data)
                let logID = logs.first(where: { $0.userID == userId && $0.cacheID == cacheId })?.logID
                if let logID = logID {
                    let url = URL(string: "https://gocache-api.herokuapp.com/api/logs/\(logID)")!
                    print(url)
                        // Create the request
                        var request = URLRequest(url: url)
                        request.httpMethod = "DELETE"
                        
                        // Set the request headers
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjA4Mzh9.dC5cFdXHQN_sIs1fBmuIuXngp-qYSyzqcH4recUCdiE", forHTTPHeaderField: "Authorization")

                                                        
                        // Send the request
                        URLSession.shared.dataTask(with: request) { data, response, error in
                            // Handle the response
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                                return
                            }
                            guard let data = data else {
                                print("No data returned from server")
                                return
                            }
                            print(String(data: data, encoding: .utf8)!)
                        }.resume()
                }
            } catch {
                print("Error decoding logs: \(error)")
            }

        }.resume()
    }
}
