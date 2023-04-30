//
//  MessageController.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation

class MessagesController: ObservableObject {
    @Published var previews: [MessageModel] = []
    @Published var chats: [Message2Model] = []
    
    private let messageAPI = MessageAPI()
    
    func fetchPreviews() {
        messageAPI.fetchPreviews { previews in
            if let previews = previews {
                DispatchQueue.main.async {
                    self.previews = previews
                }
            }
        }
    }
    
    func fetchChats(recipientID: Int) {
        messageAPI.fetchChats(recipientID:recipientID) { chats in
            if let chats = chats {
                DispatchQueue.main.async {
                    self.chats = chats
                }
            }
        }
    }
    
    func createMessage(recipientID: Int, text: String, completion: @escaping (Bool) -> Void) {
        messageAPI.createMessage(recipientID: recipientID, text: text) { success in
            completion(success)
        }
    }
    
    func deleteMessage(messageID: Int, completion: @escaping (Bool) -> Void) {
        messageAPI.deleteMessage(messageID: messageID) { success in
            completion(success)
        }
    }
}
