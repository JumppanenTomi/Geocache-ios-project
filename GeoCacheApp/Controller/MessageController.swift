//
//  MessageController.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/22/23.
//

import Foundation

class MessagesController: ObservableObject {
    @Published var messages: [MessageModel] = []
    
    private let messageAPI = MessageAPI()
    
    func fetchMessages() {
        messageAPI.fetchMessages { messages in
            if let messages = messages {
                DispatchQueue.main.async {
                    self.messages = messages
                }
            }
        }
    }
}
