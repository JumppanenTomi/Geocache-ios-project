//
//  detailsSheet.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import SwiftUI

struct detailsSheet: View {
    let cache: Cache
    
    var body: some View {
            VStack {
                HStack {
                    Text(cache.name)
                        .font(.title)
                    Spacer()
                    Text("#\(String(cache.id))")
                        .font(.caption)
                }
                HStack{
                    VStack(alignment: .leading){
                        HStack {
                            Text("Difficulty: ")
                            IntToDots(value: cache.difficulty, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                        }
                        HStack {
                            Text("Size: ")
                            IntToDots(value: cache.size, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                        }
                    }
                    Spacer()
                    Button("Track"){}
                        .buttonStyle(.bordered)
                    Button("Mark found"){}
                        .buttonStyle(.bordered)
                }
                Divider()
                ScrollView{
                    Text(cache.description)
                }
                Divider()
                Text("Cache was hidden by \(cache.user.username).")
            }
            .padding()
    }
}
