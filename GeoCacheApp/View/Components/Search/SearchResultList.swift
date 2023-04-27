//
//  SearchResultList.swift
//  GeoCacheApp
//
//  Created by iosdev on 18.4.2023.
//

import SwiftUI

struct SearchResultList: View {
    var searchText: String
    @State var searchResults: [MatchingCache] = []
    @EnvironmentObject var modelData: ModelData

    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(searchResults, id: \.id) { matchingCache in
                SearchItem(id: matchingCache.id, title: matchingCache.name, difficulty: matchingCache.difficulty, size: matchingCache.size, coordinates: matchingCache.coordinates)
            }
        }
        .onAppear {
            searchResults = searchCache(searchText: searchText, modelData: modelData)
        }
    }
}
