//
//  Messages.swift
//  GeoCacheApp
//
//  Created by iosdev on 9.4.2023.
//

import SwiftUI

struct Messages: View {
    @StateObject var messagesController = MessagesController()
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        HStack {
                            Text("Chats")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                                .padding(.top, 10)
                            
                            Spacer()
                            NavigationLink(destination: UserView()) {
                                Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 20)
                                    .padding(.top, 10)
                            }
                            
                        }
                        
                        Divider()
                        
                        ScrollView {
                            LazyVStack {
                                ForEach(messagesController.previews) { preview in
                                    NavigationLink(destination: ChatView(contact: preview.user.username, recipientID: preview.recipientID)) {
                                        ChatPreviewListItem(contact: preview.user.username, message: preview.text, timestamp: preview.createdAt)
                                    }
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 60)
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    messagesController.fetchPreviews()
                }
            }
        }
}

/*
struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
*/
