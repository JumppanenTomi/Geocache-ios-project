//
//  detailsSheet.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import SwiftUI

struct detailsSheet: View {
    let cacheId: Int
    @EnvironmentObject var modelData: ModelData
    
    
    var body: some View {
        if let index = modelData.caches.firstIndex(where: { $0.id == cacheId }) {
            VStack {
                HStack {
                    Text(modelData.caches[index].name)
                        .font(.title)
                    Spacer()
                    Text("#\(String(modelData.caches[index].id))")
                        .font(.caption)
                }
                HStack{
                    VStack(alignment: .leading){
                        HStack {
                            Text("Difficulty: ")
                            IntToDots(value: modelData.caches[index].difficulty, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                        }
                        HStack {
                            Text("Size: ")
                            IntToDots(value: modelData.caches[index].size, scale: 5, fontSize: 8, iconSpacing: CGFloat(2))
                        }
                    }
                    Spacer()
                    if modelData.caches[index].foundByCurrentUser == false {
                        Button("Track"){}
                            .buttonStyle(.bordered)
                    }
                    Button(modelData.caches[index].foundByCurrentUser ? "Remove from founded" : "Mark Found"){
                        if modelData.caches[index].foundByCurrentUser{
                            ModelData().deleteLog(userId: 1, cacheId: cacheId)
                        } else{
                            ModelData().foundCache(cacheId: cacheId)
                        }
                        modelData.caches[index].foundByCurrentUser.toggle()
                    }
                    .buttonStyle(.bordered)
                    .accentColor(modelData.caches[index].foundByCurrentUser ? .red : .blue)
                }
                Divider()
                ScrollView{
                    VStack(alignment: .leading){
                        Text("Description")
                            .font(.title)
                        Text(modelData.caches[index].description)
                        Divider()
                        Text("Hint")
                            .font(.title)
                        Text(modelData.caches[index].hint)
                    }
                }
                Spacer()
                Divider()
                Text("Cache was hidden by \(modelData.caches[index].user.username).")
            }
            .padding()
        }
    }
}
