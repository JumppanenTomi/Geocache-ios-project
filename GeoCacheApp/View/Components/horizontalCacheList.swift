//
//  horizontalCacheList.swift
//  GeoCacheApp
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI

struct horizontalCacheList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var selectedCache: Cache? = nil
    
    var body: some View {
        GeometryReader{geometry in
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(modelData.caches){cache in
                        horizontalListItem(id: cache.id, title: cache.name, difficulty: cache.difficulty, size: cache.size, isClickable: true)
                            .frame(
                                width: CGFloat(Int(geometry.size.width * 0.9)),
                                height: 200
                            )
                            .onTapGesture{
                                selectedCache = cache
                            }
                            .sheet(item: $selectedCache){cache in
                                detailsSheet(cache: cache)
                                    .presentationDetents([.medium, .large])
                            }
                    }
                }
            }
        }
    }
}

struct horizontalCacheList_Previews: PreviewProvider {
   static var previews: some View {
        horizontalCacheList()
            .environmentObject(ModelData())
    }
}
