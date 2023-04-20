import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var userViewModel = UserViewModel(user: User(name: "John Doe", profileImage: UIImage(systemName: "person.crop.circle.fill")!, bio: "I love geocaching!", cachesFound: 42, cachesCreated: 10))

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<5) { index in
                        viewForIndex(index: index)
                            .opacity(selectedTab == index ? 1 : 0)
                            .offset(x: selectedTab == index ? 0 : geometry.size.width)
                            .animation(.spring(), value: selectedTab)
                    }
                }
                .frame(width: geometry.size.width)
                .edgesIgnoringSafeArea(.top)

                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 50)
                    .background(Color(.systemBackground))
            }
        }
    }
    
    func viewForIndex(index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(Home())
        case 1:
            return AnyView(Pins())
        case 2:
            return AnyView(AddCache())
        case 3:
            return AnyView(Messages())
        case 4:
            return AnyView(Profile(userViewModel: userViewModel))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        selectedTab = index
                    }
                }) {
                    tabBarIconForIndex(index: index)
                }
            }
            Spacer()
        }
    }
    
    func tabBarIconForIndex(index: Int) -> some View {
        let imageName: String
        switch index {
        case 0:
            imageName = "house"
        case 1:
            imageName = "pin"
        case 2:
            imageName = "plus.circle"
        case 3:
            imageName = "message"
        case 4:
            imageName = "person.crop.circle.fill"
        default:
            return AnyView(EmptyView())
        }
        
        let scaleEffect = selectedTab == index ? 1.2 : 1.0
        
        return AnyView(Image(systemName: imageName)
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == index ? .accentColor : .gray)
                        .scaleEffect(CGSize(width: scaleEffect, height: scaleEffect))
                        .animation(.spring(), value: selectedTab))
    }
}
