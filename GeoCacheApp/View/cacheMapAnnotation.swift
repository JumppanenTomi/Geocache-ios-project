//
//  cacheMapAnnotation.swift
//  GeoCacheApp
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct cacheMapAnnotation: View {
    @State private var isTapped = false

    var body: some View {
        
        VStack(spacing: 0) {
          Image(systemName: "cube.box.fill")
            .font(.title)

          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .offset(x: 0, y: -5).onTapGesture {
                self.isTapped.toggle()
            }
        }
    }
}

struct cacheMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        cacheMapAnnotation()
    }
}
