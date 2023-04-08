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
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: {
                if isRecording {
                    speechRecognizer.stopRecording()
                } else {
                    speechRecognizer.startRecording { (text, error) in
                        if let text = text {
                            self.searchText = text
                        }
                    }
                }
                isRecording.toggle()
            }) {
                Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                    .padding()
            }
        }
    }
}



struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar()
    }
}
