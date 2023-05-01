//
//  Message.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation


struct MessageModel: Codable, Identifiable {
    let messageID: Int
    let senderID: Int
    let recipientID: Int
    let text: String
    let createdAt: String
    let updatedAt: String
    let user: UserModel
    
    enum CodingKeys: String, CodingKey {
        case messageID = "messageID"
        case senderID = "senderID"
        case recipientID = "recipientID"
        case text = "text"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case user = "user"
    }
    var id: String {
            return String(messageID)
        }
}

struct Message2Model: Codable, Identifiable {
    let messageID: Int
    let senderID: Int
    let recipientID: Int
    let text: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case messageID = "messageID"
        case senderID = "senderID"
        case recipientID = "recipientID"
        case text = "text"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    var id: String {
            return String(messageID)
        }
}
