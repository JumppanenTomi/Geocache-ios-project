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
        NavigationStack{
            List {
                ForEach(messagesController.messages) { message in
                    NavigationLink(destination: Chat(contact: message.text)) {
                        ContactItems(contact: message.user.username)
                    }
                }
                .navigationTitle("Contacts")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear{
                messagesController.fetchMessages()
            }
        }
    }
}


struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
