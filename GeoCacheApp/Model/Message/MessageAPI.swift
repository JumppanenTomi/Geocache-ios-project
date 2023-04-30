//
//  MessageAPI.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation

class MessageAPI {
    let baseURL = "https://gocache-api.herokuapp.com/api"
    let headers = ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2ODIxNjI0Njh9.F9OX6HogLKDzr0xDdiu3BG63TALGx1lRwpVbk0DK9t4", "Content-Type": "application/json"]
    
    func fetchPreviews(completion: @escaping ([MessageModel]?) -> Void) {
        guard let url = URL(string: baseURL + "/chatPreviews") else {
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
                let previews = try JSONDecoder().decode([MessageModel].self, from: data)
                completion(previews)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchChats(recipientID: Int, completion: @escaping ([Message2Model]?) -> Void) {
        guard let url = URL(string: baseURL + "/chats/" + String(recipientID)) else {
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
                let chats = try JSONDecoder().decode([Message2Model].self, from: data)
                completion(chats)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func createMessage(recipientID: Int, text: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL + "/messages") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let messageData: [String: Any] = ["senderID": 1, "recipientID": recipientID, "text": text]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: messageData, options: []) else {
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    func deleteMessage(messageID: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL + "/messages/" + String(messageID)) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
}
