//
//  MapView.swift
//  GeoCacheApp
//
//  Created by iosdev on 11.4.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var tracking: MapUserTrackingMode = .follow
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var manager: LocationManager
    @Binding var selectedCache: Cache?
   

    
    var body: some View {
       
        Map(coordinateRegion: $manager.region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            annotationItems: modelData.caches
            
        ){cache in
            MapAnnotation(coordinate: cache.locationCoordinates) {
                cacheMapAnnotation()
                    .onTapGesture {
                        manager.region.center = cache.locationCoordinates
                        manager.zoomBack()
                        selectedCache = cache
                            }.foregroundColor((selectedCache == cache) ? .red : .purple).shadow(radius: 1)
            }
        }
        .ignoresSafeArea()
        
        Button(action: {
            manager.region.center = manager.location.coordinate
            manager.zoomBack()
            
        }, label: {
            Image(systemName: "location.circle").font(.system(size: 40))
        }).padding(.bottom, 200).offset(x: 140).shadow(radius: 0.5)
        
    }
    

}
