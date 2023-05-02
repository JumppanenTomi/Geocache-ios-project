import Foundation

class AuthAPI: ObservableObject {
    let baseURL = "https://gocache-api.herokuapp.com/api"
    let headers = ["Content-Type": "application/json"]
    
    func register(username: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL + "/auth/register") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let registerData: [String: Any] = ["username": username, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: registerData, options: []) else {
            completion(false)
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: baseURL + "/login") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let loginData: [String: Any] = ["username": username, "password": password]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData, options: []) else {
            completion(false, nil)
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let token = json["token"] as? String {
                    completion(true, token)
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }.resume()
    }
}
