//
//  LocationManager.swift
//  GeoCacheApp
//
//
//

import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    @Published var location = CLLocation()
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func zoomBack(){
        region.span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        
    }
    func offsetCenter(center: CLLocationCoordinate2D)-> CLLocationCoordinate2D{
        let offsetLat: CLLocationDegrees =  -0.001
        let offsetLng: CLLocationDegrees = 0
        let offsetCoordinate = CLLocationCoordinate2D(latitude: center.latitude + offsetLat, longitude: center.longitude + offsetLng)
        return offsetCoordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
               self.location = location
               manager.stopUpdatingLocation()
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
            )
        }
        
    }
    
    
}
