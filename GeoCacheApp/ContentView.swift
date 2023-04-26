import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var userViewModel = UserViewModel(user: User(name: "John Doe", profileImage: UIImage(systemName: "person.crop.circle.fill")!, bio: "I love geocaching!", cachesFound: 42, cachesCreated: 10))

    var body: some View {
        TabView(selection: $selectedTab){
            Home()
                .tag(1)
                .environmentObject(ModelData())
                .environmentObject(LocationManager())
                .tabItem{
                    Image(systemName: "house")
                }
            Pins()
                .tag(2)
                .tabItem{
                    Image(systemName: "pin")
                }
            AddCache()
                .tag(3)
                .tabItem{
                    Image(systemName: "plus.circle")
                }
            Messages()
                .tag(4)
                .tabItem{
                    Image(systemName: "message")
                }
            Profile(userViewModel: userViewModel)
                .tag(5)
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                }
        }
    }
}
