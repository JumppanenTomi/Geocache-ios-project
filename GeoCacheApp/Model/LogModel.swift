//
//  LogModel.swift
//  GeoCacheApp
//
//  Created by iosdev on 2.5.2023.
//

import Foundation

struct Log: Codable {
    let logID: Int
    let logType: String
    let logComment: String
    let cacheID: Int
    let createdAt: String
    let updatedAt: String
    let userID: Int
}
