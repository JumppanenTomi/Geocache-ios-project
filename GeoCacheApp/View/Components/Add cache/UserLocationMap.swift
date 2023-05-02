import SwiftUI
import MapKit

struct UserLoactionMap: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var coordinate: CLLocationCoordinate2D?
    let regionRadius: CLLocationDistance = 5000
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: UserLoactionMap
        
        init(_ parent: UserLoactionMap) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            // Update the coordinate binding whenever the user interacts with the map
            parent.coordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Create a pin annotation view for the dropped pin
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.animatesWhenAdded = true
            annotationView.isDraggable = true
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            // Update the coordinate binding whenever the user drags the dropped pin
            if newState == .ending {
                parent.coordinate = view.annotation?.coordinate
            }
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // If the coordinate binding changes, update the map view's center coordinate and drop a pin at the selected location
            if let coordinate = coordinate {
                uiView.removeAnnotations(uiView.annotations)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                uiView.addAnnotation(annotation)
                uiView.setCenter(coordinate, animated: true)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

struct MapSelector: View {
    
    @Binding var coordinate: CLLocationCoordinate2D?
    @State var userCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    var body: some View {
        VStack {
            Text("Select a location:")
                .font(.title)
            UserLoactionMap(centerCoordinate: $userCoordinate ,coordinate: $coordinate)
                .frame(height: 300)
                .cornerRadius(16)
            if let coordinate = coordinate {
                Text("Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
                    .padding()
            }
        }
    }
}
