//
//  cacheMapAnnotation.swift
//  GeoCacheApp
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct cacheMapAnnotation: View {
    var body: some View {
        VStack(spacing: 0) {
          Image(systemName: "cube.box.fill")
            .font(.title)
            .foregroundColor(.pink)
          
          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(.pink)
            .offset(x: 0, y: -5)
        }
    }
}

struct cacheMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        cacheMapAnnotation()
    }
}
