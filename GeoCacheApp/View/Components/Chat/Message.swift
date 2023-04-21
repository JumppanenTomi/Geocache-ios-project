//
//  Message.swift
//  GeoCacheApp
//
//  Created by iosdev on 21.4.2023.
//

import SwiftUI

struct Message: View {
    var message: String
    var sender: Bool
    
    var body: some View {
        HStack {
            if sender{
                Spacer()
            }
            Text(message)
                .padding()
                .foregroundColor(Color(sender ? .white : .black))
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(sender ? .systemGreen : .systemGray6))
                )
                .frame(maxWidth: 250)
                .fixedSize(horizontal: false, vertical: true)
            if !sender{
                Spacer()
            }
        }
    }
}

struct Message_Previews: PreviewProvider {
    static var previews: some View {
        Message(message: "Hello world! Hello world! Hello world! Hello world! Hello world!", sender: true)
    }
}
