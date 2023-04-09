//
//  Home.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI
import MapKit

struct Home: View {
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Map(
                    coordinateRegion: $manager.region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking
                )
            }
            .ignoresSafeArea()
            Button(action: {
                print("clicked")
                tracking = .follow
                
            }, label: {
                Image(systemName: "location.circle").font(.system(size: 40))
            }).padding(.top, 60).offset(x: 140)
            
            VStack {
                searchBar()
                Spacer()
                horizontalCacheList()
                    .environmentObject(ModelData())
                    .frame(
                        height: 200
                    )
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
