//
//  ChatView.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/27/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var messagesController = MessagesController()
    @State private var messageText = ""
    let contact: String
    let recipientID: Int
    
    var body: some View {
        VStack {
            // Navigation Bar
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
                Text(contact)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                /*
                 Menu {
                 Button(action: {
                 // Handle delete action
                 }) {
                 Text("Delete")
                 }
                 } label: {
                 Image(systemName: "ellipsis")
                 .foregroundColor(.green)
                 }
                 */
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            // Chat Bubble
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(messagesController.chats) { chat in
                        ChatBubbleListItem(side: chat.senderID == recipientID ? .left : .right, text: chat.text, time: chat.createdAt, deleteAction: {
                            messagesController.deleteMessage(messageID: chat.messageID) { success in
                                if success {
                                    DispatchQueue.main.async {
                                        messagesController.fetchChats(recipientID: recipientID)
                                    }
                                }
                            }
                        })
                    }
                }
            }
            
            // Text Input Field
            HStack {
                TextField("Type a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 8)
                Button(action: {
                    if !messageText.isEmpty {
                        messagesController.createMessage(recipientID: recipientID, text: messageText) { success in
                            if success {
                                DispatchQueue.main.async {
                                    messagesController.fetchChats(recipientID: recipientID)
                                }
                            }
                        }
                        messageText = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.green)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .onAppear {
            messagesController.fetchChats(recipientID: recipientID)
        }
    }
}
