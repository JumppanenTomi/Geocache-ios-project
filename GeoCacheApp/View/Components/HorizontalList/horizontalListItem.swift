//
//  SwiftUIView.swift
//  GeoCacheApp
//
//  Created by iosdev on 4.4.2023.
//

import SwiftUI

struct horizontalListItem: View {
    var id: Int
    var title: String
    var difficulty: Int
    var size: Int
    var isClickable: Bool = false

    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        HStack {
                            VStack {
                                Text(title)
                                    .font(.title)
                                Spacer()
                            }
                            Spacer()
                            VStack {
                                Text("#\(id)")
                                    .font(.subheadline)
                                .opacity(0.5)
                                Spacer()
                            }
                        }
                    }
                    Divider()
                    HStack{
                        Text("Difficulty: ")
                            .font(.subheadline)
                            .padding(5)
                        IntToDots(value: difficulty, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                    }
                    HStack{
                        Text("Size: ")
                            .font(.subheadline)
                            .padding(5)
                        IntToDots(value: size, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                    }
                    Spacer()
                }
                if isClickable{
                    Spacer()
                    VStack {
                        Label("", systemImage: "chevron.forward")
                            .font(.system(size: 35))
                    }
                }
            }
            .padding()
            .background(Rectangle().fill(Color.white).cornerRadius(15).shadow(radius: 3))
            .padding()
    }
}


struct horizontalListItem_Previews: PreviewProvider {
    static var previews: some View {
        horizontalListItem(id: 1, title: "This is paragraph is shown in preview", difficulty: 3, size: 1, isClickable: true)
    }
}
