//
//  Messages.swift
//  GeoCacheApp
//
//  Created by iosdev on 9.4.2023.
//

import SwiftUI

struct Messages: View {
    var body: some View {
        NavigationStack{
            List {
                NavigationLink(destination: Chat(contact: "John Doe")) {
                    ContactItems(contact: "John Doe")
                }
                .navigationTitle("Contacts")
            }
        }
    }
}


struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
