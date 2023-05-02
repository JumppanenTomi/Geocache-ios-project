import SwiftUI

struct Login: View {
    @State private var username = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    @StateObject private var authAPI = AuthAPI()
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("GoCache")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 30)
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 50)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Perform login action
                    if username != "" && password != "" {
                        authAPI.login(username: username, password: password) { success, token in
                            if success, let token = token {
                                DispatchQueue.main.async {
                                    // Save the token and update isLoggedIn
                                    userViewModel.name = username
                                    isLoggedIn = true
                                }
                            } else {
                                print("Login failed")
                            }
                        }
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                        .shadow(radius: 2)
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: Register()) {
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}
