//
//  MapView.swift
//  GeoCacheApp
//
//  Created by iosdev on 11.4.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow
    @EnvironmentObject var modelData: ModelData

    
    
    var body: some View {
       
        Map(
            coordinateRegion: $manager.region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $tracking,
            annotationItems: modelData.caches
        ){
            MapMarker(coordinate: $0.locationCoordinates)}
        .ignoresSafeArea()
        
        Button(action: {
            self.tracking = .follow
            manager.zoomBack()
            
        }, label: {
            Image(systemName: "location.circle").font(.system(size: 40))
        }).padding(.bottom, 200).offset(x: 140)
        
    }
    
    struct MapView_Preview: PreviewProvider {
        static var previews: some View {
            MapView()
        }
    }
}
