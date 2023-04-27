//
//  SwiftUIView.swift
//  GeoCacheApp
//
//  Created by iosdev on 4.4.2023.
//

import SwiftUI
import CoreLocation

struct SearchItem: View {
    var id: Int
    var title: String
    var difficulty: Int
    var size: Int
    var coordinates: CLLocationCoordinate2D

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Text(calculateDistance(latitude: coordinates.latitude, longitude: coordinates.longitude))
                    .font(.subheadline)
            }
            .padding(5)
            HStack{
                Text("Difficulty: ")
                    .font(.subheadline)
                IntToDots(value: difficulty, scale: 5, fontSize: 7, iconSpacing: CGFloat(2))
                Text("Size: ")
                    .font(.subheadline)
                IntToDots(value: size, scale: 5, fontSize: 7, iconSpacing: CGFloat(2))
                Spacer()
            }
            .padding(5)
        }
        .padding()
        .background(Rectangle().fill(Color.white).cornerRadius(15))
        .padding(.horizontal)
    }
}
