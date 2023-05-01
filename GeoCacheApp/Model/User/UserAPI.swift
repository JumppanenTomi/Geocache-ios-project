//
//  UserAPI.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/30/23.
//

import Foundation

class UserAPI {
    let baseURL = "https://gocache-api.herokuapp.com/api"
    let headers = ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjI0Njh9.F9OX6HogLKDzr0xDdiu3BG63TALGx1lRwpVbk0DK9t4", "Content-Type": "application/json"]
    
    func fetchUsers(completion: @escaping ([UserModel]?) -> Void) {
        guard let url = URL(string: baseURL + "/users") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                completion(users)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
