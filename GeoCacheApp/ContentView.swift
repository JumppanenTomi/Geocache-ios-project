//
//  ContentView.swift
//  GeoCacheApp
//
//  Created by iosdev on 4.4.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow

        
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(
                coordinateRegion: $manager.region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $tracking
            )
            
            Button(action: {
                print("clicked")
                tracking = .follow
                
            },label: {Image(systemName: "location.circle").font(.system(size:40))
                
            }).padding( .bottom, 60).offset(x: 140)
        
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
