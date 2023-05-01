import SwiftUI

struct Register: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Sign Up")
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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Perform registration action
                    // Navigate back to the login page upon successful registration
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Sign up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                        .shadow(radius: 2)
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: Login(isLoggedIn: .constant(false))) {
                    Text("Already have an account? Login")
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

