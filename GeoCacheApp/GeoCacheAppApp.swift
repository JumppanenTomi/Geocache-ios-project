import SwiftUI

@main
struct GeoCacheAppApp: App {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(modelData)
        }
    }
}
