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
    @ObservedObject var manager: LocationManager
    @Binding var selectedCache: Cache?
   

    
    var body: some View {
       
        Map(
            coordinateRegion: $manager.region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $tracking,
            annotationItems: modelData.caches
        ){cache in
            MapAnnotation(coordinate: cache.locationCoordinates) {
                cacheMapAnnotation()
                    .onTapGesture {
                    print(cache.name)
                        selectedCache = cache
                        manager.region.center = cache.locationCoordinates
                        manager.region.span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)

                }
            }
        }
        .ignoresSafeArea()
        
        Button(action: {
            manager.region.center = manager.location.coordinate
            manager.zoomBack()
            
        }, label: {
            Image(systemName: "location.circle").font(.system(size: 40))
        }).padding(.bottom, 200).offset(x: 140)
        
    }
    
    struct MapView_Preview: PreviewProvider {
        static var previews: some View {
            MapView(manager: LocationManager(), selectedCache: .constant(nil))
        }
    }
}
