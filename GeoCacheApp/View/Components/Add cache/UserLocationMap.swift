//
//  UserLocationMap.swift
//  GeoCacheApp
//
//  Created by iosdev on 26.4.2023.
//

import SwiftUI
import MapKit

struct UserLocationMap: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        guard let coordinate = coordinate else {
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        view.setRegion(region, animated: true)
    }
}

struct UserLocationMap_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationMap()
    }
}
