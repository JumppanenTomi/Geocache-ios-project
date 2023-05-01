//
//  UserController.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/30/23.
//

import Foundation

class UserController: ObservableObject {
    @Published var users: [UserModel] = []
    
    private let userAPI = UserAPI()
    
    func fetchUsers() {
        userAPI.fetchUsers { users in
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                }
            }
        }
    }
}
