import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var userViewModel = UserViewModel(user: User(name: "John Doe", profileImage: UIImage(systemName: "person.crop.circle.fill")!, bio: "I love geocaching!", cachesFound: 42, cachesCreated: 10))
    @State private var activeLink: Int?

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if selectedTab == 0 {
                        Home()
                            .environmentObject(ModelData())
                            .environmentObject(LocationManager())
                            .transition(.slide)
                    } else if selectedTab == 1 {
                        Pins()
                            .transition(.slide)
                    } else if selectedTab == 2 {
                        AddCache()
                            .transition(.slide)
                    } else if selectedTab == 3 {
                        Messages()
                            .transition(.slide)
                    } else if selectedTab == 4 {
                        Profile(userViewModel: userViewModel)
                            .transition(.slide)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)

                Spacer()

                HStack {
                    button(for: 0, systemImageName: "house")
                    button(for: 1, systemImageName: "pin")
                    button(for: 2, systemImageName: "plus.circle")
                    button(for: 3, systemImageName: "message")
                    button(for: 4, systemImageName: "person.crop.circle.fill")
                }
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if selectedTab == 4 {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                activeLink = 1
                            }
                        }) {
                            Image(systemName: "gearshape")
                                .rotationEffect(activeLink == 1 ? .degrees(360) : .degrees(0))
                        }
                    }
                }
            }
            .background(
                NavigationLink("Settings", tag: 1, selection: $activeLink) {
                    Settings()
                }
                .opacity(0)
            )
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    private func button(for index: Int, systemImageName: String) -> some View {
        Button(action: {
            withAnimation {
                selectedTab = index
            }
        }) {
            Image(systemName: systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(.all, 10)
        }
        .foregroundColor(selectedTab == index ? .blue : .gray)
    }
}

