//
//  File.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/30/23.
//

import SwiftUI

struct UserView: View {
    @StateObject var usersController = UserController()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select User")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.leading, 20)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(usersController.users) { user in
                        NavigationLink(destination: ChatView(contact: user.username, recipientID: user.userID)) {
                            UserListItem(name: user.username)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            usersController.fetchUsers()
        }
    }
}
