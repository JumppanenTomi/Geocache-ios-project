//
//  Profile.swift
//  GeoCacheApp
//
//  Created by iosdev on 9.4.2023.
//

import SwiftUI

struct Profile: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "gear")
                .font(.system(size: 24))
            })
            .sheet(isPresented: $isPresented, content: {
            Settings()
            })
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}