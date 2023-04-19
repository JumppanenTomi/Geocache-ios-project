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
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(searchResults, id: \.id) { matchingCache in
                SearchItem(id: matchingCache.id, title: matchingCache.name)
            }
        }
        .onAppear {
            searchResults = searchCache(searchText: searchText)
        }
    }
}


struct SearchResultList_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultList(searchText: "Turtle")
    }
}
