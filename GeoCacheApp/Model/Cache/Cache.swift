//
//  Cache.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import SwiftUI
import Foundation
import CoreLocation

struct Cache: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var difficulty: Int
    var size: Int
    var author: String
    var isFeatured: Bool
    var description: String
    
    private var coordinates: Coordinates
    var locationCoordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
    }
}
