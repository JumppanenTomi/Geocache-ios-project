//
//  Home.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI
import MapKit

struct Home: View {
    @State var selectedCache: Cache? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(selectedCache: $selectedCache)
                
            HStack {
                VStack {
                    searchBar()
                    Spacer()
                    horizontalCacheList(selectedCache: $selectedCache)
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
