//
//  calculateDistance.swift
//  GeoCacheApp
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI
import MapKit

func calculateDistance(latitude: Double, longitude: Double) -> String {
    let userLocation = CLLocationManager()
    var distance: CLLocationDistance = 0
    
    if userLocation.authorizationStatus == .authorizedWhenInUse || userLocation.authorizationStatus == .authorizedAlways {
        if let location = userLocation.location {
            let userCoordinate = location.coordinate
            let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
            let destinationLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
            distance = userLocation.distance(from: destinationLocation) / 1000 // Convert distance to kilometers
        }
    }
    
    if distance < 1 {
        let distanceInMeters = Int(distance * 1000)
        return "\(distanceInMeters) meters away"
    } else {
        let formattedDistance = String(format: "%.2f", distance)
        return "\(formattedDistance) km away"
    }
}
