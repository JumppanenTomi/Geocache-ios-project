//
//  userLocation.swift
//  GeoCacheApp
//
//  Created by iosdev on 26.4.2023.
//

import CoreLocation

func getUserLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        if let location = locationManager.location {
            let coordinate = location.coordinate
            completion(coordinate)
        } else {
            completion(nil)
        }
    } else {
        completion(nil)
    }
}
