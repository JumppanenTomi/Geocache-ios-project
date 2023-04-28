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
                    ForEach(modelData.caches.sorted(by: { calculateDistance(latitude: $0.locationCoordinates.latitude, longitude: $0.locationCoordinates.longitude) < calculateDistance(latitude: $1.locationCoordinates.latitude, longitude: $1.locationCoordinates.longitude) })){cache in
                        horizontalListItem(id: cache.id, title: cache.name, difficulty: cache.difficulty, size: cache.size, longitude: cache.locationCoordinates.longitude, latitude: cache.locationCoordinates.latitude, isClickable: true)
                            .frame(
                                width: CGFloat(Int(geometry.size.width * 0.9))                            )
                            .onTapGesture{
                                selectedCache = cache
                                manager.region.center = cache.locationCoordinates

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


