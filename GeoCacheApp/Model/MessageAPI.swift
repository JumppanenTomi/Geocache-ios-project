//
//  MessageAPI.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation

class MessageAPI {
    let baseURL = "https://gocache-api.herokuapp.com/api/messages?include=users"
    let headers = ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjI0Njh9.F9OX6HogLKDzr0xDdiu3BG63TALGx1lRwpVbk0DK9t4"]

    func fetchMessages(completion: @escaping ([MessageModel]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let messages = try JSONDecoder().decode([MessageModel].self, from: data)
                print(messages)
                completion(messages)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
