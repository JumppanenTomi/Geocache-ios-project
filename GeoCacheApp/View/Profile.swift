//
//  Profile.swift
//  GeoCacheApp
//
//  Created by iosdev on 9.4.2023.
//

// Profile.swift
import SwiftUI

struct Profile: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var editingUsername = false

    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: userViewModel.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture {
                    showingImagePicker = true
                }

            if editingUsername {
                TextField("", text: $userViewModel.name)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onSubmit {
                        editingUsername = false
                    }
            } else {
                Text(userViewModel.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .onTapGesture {
                        editingUsername = true
                    }
            }

            TextField("Bio", text: $userViewModel.bio)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            HStack(spacing: 80) {
                VStack {
                    Text("\(userViewModel.cachesFound)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    Text("Found")
                        .font(.callout)
                        .foregroundColor(Color.secondary)
                }
                VStack {
                    Text("\(userViewModel.cachesCreated)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    Text("Created")
                        .font(.callout)
                        .foregroundColor(Color.secondary)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 50)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        userViewModel.profileImage = inputImage
    }
}
