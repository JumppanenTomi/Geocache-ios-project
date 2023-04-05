//
//  ContentView.swift
//  GeoCacheApp
//
//  Created by iosdev on 4.4.2023.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true, userTrackingMode: .constant(.follow)
            )
            Spacer()
            
            Button(action: {}){
                Image(systemName: "location.circle").font(.system(size:40)).offset(x:150, y:300)
                            }
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
