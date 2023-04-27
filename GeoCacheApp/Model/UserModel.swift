//
//  UserModel.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation

struct UserModel: Codable, Identifiable {
    let userID: Int
    let username: String
    let password: String
    let email: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case username = "username"
        case password = "password"
        case email = "email"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    var id: String {
        return String(userID)
    }
}
