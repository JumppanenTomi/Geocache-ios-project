//
//  searchBar.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI

struct searchBar: View {
    @State var searchText: String = ""
    @State private var isRecording: Bool = false
    @ObservedObject private var speechRecognizer = SpeechRecognizer()
    @State private var isSearching: Bool = false
    @EnvironmentObject var modelData: ModelData
    @State var selectedCache: MatchingCache? = nil

    
    var body: some View {
        HStack {
            if searchText != ""{
                Button(action: {searchText = ""}) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.leading, 10)
                }
            }
            TextField("Search", text: $searchText)
                .font(.system(size: 14))
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
                            searchCache(searchText: text, modelData: modelData)
                            isSearching = true
                        }
                    }
                }
                isRecording.toggle()
            }) {
                Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 14))
            }
            if searchText != ""{
                Button(action: {isSearching = true}) {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 14))
                        .padding(.leading, 10)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 50).fill(Color(.systemGray6)))
                .padding(.vertical, 5)
                .autocapitalization(.sentences)
                .padding()
        if isSearching && searchText != ""{
            SearchResultList(searchText: $searchText, selectedCache: $selectedCache)
        }
    }
}



struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar()
    }
}
