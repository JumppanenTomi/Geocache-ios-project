//
//  Chat.swift
//  GeoCacheApp
//
//  Created by iosdev on 20.4.2023.
//

import SwiftUI

struct Chat: View {
    var image: Image = Image("profile-image")
    var contact: String
    @State private var message = ""

    var body: some View {
        VStack {
            HStack{
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                Spacer()
                Text(contact)
                    .font(.title2)
            }
            .padding()
            Spacer()
            ScrollView(.vertical){
                Text("Messages")
            }
            HStack {
                TextField("iMessage", text: $message)
                    .padding(.horizontal)
                        Button(action: {}) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 25))
                        }
                        .padding(.trailing, 8)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50).fill(Color(.systemGray6)))
                    .frame(height: 30)
                    .padding(.vertical, 8)
                    .autocapitalization(.sentences)
                    .padding()
        }
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(contact: "John Doe")
    }
}
