//
//  UserListItem.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/30/23.
//

import SwiftUI

struct UserListItem: View {
    let name: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 2)
                
                Divider()
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
}
