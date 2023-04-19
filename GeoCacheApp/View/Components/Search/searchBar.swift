//
//  searchBar.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI

struct searchBar: View {
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    @ObservedObject private var speechRecognizer = SpeechRecognizer()
    @State private var isSearching: Bool = false
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .onSubmit {
                    isSearching = true
                }
                .onChange(of: searchText) { _ in
                        isSearching = false
                }
            
            Button(action: {
                if isRecording {
                    speechRecognizer.stopRecording()
                } else {
                    speechRecognizer.startRecording { (text, error) in
                        if let text = text {
                            self.searchText = text
                            searchCache(searchText: text)
                            isSearching = true
                        }
                    }
                }
                isRecording.toggle()
            }) {
                Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                    .padding()
            }
        }
        if isSearching && searchText != ""{
            SearchResultList(searchText: searchText)
        }
    }
}



struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar()
    }
}
