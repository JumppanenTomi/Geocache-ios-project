import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            Home()
                .tabItem{
                    Image(systemName: "house")
                }
            Pins()
                .tabItem{
                    Image(systemName: "pin")
                }
            AddCache()
                .tabItem{
                    Image(systemName: "plus.circle")
                }
            Messages()
                .tabItem{
                    Image(systemName: "message")
                }
            Profile()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                }
        }
    }
}
