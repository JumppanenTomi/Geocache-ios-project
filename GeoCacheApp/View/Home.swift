//
//  Home.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI
import MapKit

struct Home: View {
    @State private var selectedCache: Cache? = nil
    @StateObject var manager = LocationManager()

    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(manager: manager, selectedCache: $selectedCache).environmentObject(ModelData())
            HStack {
                VStack {
                    searchBar()
                    Spacer()
                    horizontalCacheList(manager: manager, selectedCache: $selectedCache)
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
}
