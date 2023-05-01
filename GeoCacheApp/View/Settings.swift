import SwiftUI

struct Settings: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        List {
            Section {
                LocaleSelect()
            }
            
            Section {
                Button(action: {
                    // Perform logout action
                    isLoggedIn = false
                }) {
                    HStack {
                        Spacer()
                        Text("Logout")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(isLoggedIn: .constant(true))
    }
}
