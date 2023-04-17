import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var userViewModel = UserViewModel(user: User(name: "John Doe", profileImage: UIImage(systemName: "person.crop.circle.fill")!, bio: "I love geocaching!", cachesFound: 42, cachesCreated: 10))

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
            Profile(userViewModel: userViewModel)
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                }
        }
    }
}
