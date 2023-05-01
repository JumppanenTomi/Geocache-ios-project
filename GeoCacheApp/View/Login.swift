import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    
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
                
                TextField("Email", text: $email)
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
                    if email != "" && password != "" {
                        isLoggedIn = true
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
