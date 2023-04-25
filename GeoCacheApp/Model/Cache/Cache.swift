//
//  Cache.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

struct Cache: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var difficulty: Int
    var size: Int
    var featured: String?
    var description: String
    var createdAt: String
    var updatedAt: String
    var foundByCurrentUser: Bool
    var hint: String

    
    var coordinates: Coordinates
    var user: User

    var locationCoordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: Double(coordinates.latitude)!,
            longitude: Double(coordinates.longitude)!
        )
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: String
        var longitude: String
    }

    struct User: Hashable, Codable {
        var userID: Int
        var username: String
        var password: String
        var email: String
    }

    enum CodingKeys: String, CodingKey{
        case id = "cacheID"
        case name, difficulty, size,featured, description, createdAt, updatedAt,
        foundByCurrentUser, hint, coordinates, user
    }
}
