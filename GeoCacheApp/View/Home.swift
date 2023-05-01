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
    @EnvironmentObject var modelData: ModelData

    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(selectedCache: $selectedCache).onAppear(){
                reloadCaches()
            }
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
    func reloadCaches(){
        ModelData.getGeocaches {result in
            switch result {
                case .success(let geocaches):
                // Handle successful response
                print(geocaches)
                DispatchQueue.main.async {
                    modelData.caches = geocaches
                }
                case .failure(let error):
                // Handle error
                print(error)
            }
        }
    }
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }
}
