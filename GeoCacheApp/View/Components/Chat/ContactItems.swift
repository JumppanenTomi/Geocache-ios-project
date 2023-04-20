//
//  ContactItems.swift
//  GeoCacheApp
//
//  Created by iosdev on 20.4.2023.
//

import SwiftUI

struct ContactItems: View {
    var image: Image = Image("profile-image")
    var contact: String
    
    var body: some View {
        HStack(alignment: .center){
            image
                .resizable()
                .frame(width: 50, height: 50)
            .clipShape(Circle())
            Text(contact)
                .font(.title2)
                .padding()
            Spacer()
        }
    }
}

struct ContactItems_Previews: PreviewProvider {
    static var previews: some View {
        ContactItems(contact: "John Doe")
    }
}
