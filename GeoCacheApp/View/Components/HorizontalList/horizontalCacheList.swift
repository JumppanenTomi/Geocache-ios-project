//
//  horizontalCacheList.swift
//  GeoCacheApp
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI

struct horizontalCacheList: View {
    @EnvironmentObject var modelData: ModelData
    //@State private var selectedCache: Cache? = nil
    @EnvironmentObject var manager: LocationManager
    @Binding var selectedCache: Cache?

    var body: some View {
        GeometryReader{geometry in
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(modelData.caches.sorted(by: { calculateDistanceDouble(latitude: $0.locationCoordinates.latitude, longitude: $0.locationCoordinates.longitude) < calculateDistanceDouble(latitude: $1.locationCoordinates.latitude, longitude: $1.locationCoordinates.longitude) })){cache in
                        horizontalListItem(id: cache.id, title: cache.name, difficulty: cache.difficulty, size: cache.size, longitude: cache.locationCoordinates.longitude, latitude: cache.locationCoordinates.latitude, isClickable: true)
                            .frame(
                                width: CGFloat(Int(geometry.size.width * 0.9))                            )
                            .onTapGesture{
                                selectedCache = cache
                                manager.region.center = manager.offsetCenter(center: cache.locationCoordinates)

                            }
                            .sheet(item: $selectedCache){cache in
                                detailsSheet(cacheId: cache.id)
                                    .presentationDetents([.medium, .large])
                            }.onDisappear(){
                                selectedCache = nil
                                
                            }
                    }
                }
            }
        }
    }
}


