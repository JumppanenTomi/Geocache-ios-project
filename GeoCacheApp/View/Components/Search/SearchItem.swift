//
//  SwiftUIView.swift
//  GeoCacheApp
//
//  Created by iosdev on 4.4.2023.
//

import SwiftUI

struct SearchItem: View {
    var id: Int
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Text("#\(id)")
                .font(.subheadline)
                .opacity(0.5)
        }
        .padding()
        .background(Rectangle().fill(Color.white).cornerRadius(15).shadow(radius: 3))
        .padding(.horizontal)
        Spacer()
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem(id: 1, title: "This is paragraph is shown in preview")
    }
}
