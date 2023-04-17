//
//  Home.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI
import MapKit

struct Home: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView().environmentObject(ModelData())
            HStack {
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
}
