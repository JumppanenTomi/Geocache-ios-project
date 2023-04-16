//
//  UserViewModel.swift
//  GeoCacheApp
//
//  Created by iosdev on 16.4.2023.
//

// UserViewModel.swift
// UserViewModel.swift
import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var name: String
    @Published var profileImage: UIImage
    @Published var bio: String
    @Published var cachesFound: Int
    @Published var cachesCreated: Int

    init(user: User) {
        self.name = user.name
        self.profileImage = user.profileImage
        self.bio = user.bio
        self.cachesFound = user.cachesFound
        self.cachesCreated = user.cachesCreated
    }
}


