import Foundation
import Combine
import CoreLocation



struct MatchingCache: Identifiable {
    var id: Int
    var name: String
    var difficulty: Int
    var size: Int
    var description: String
    var createdAt: String
    var updatedAt: String
    var foundByCurrentUser: Bool
    var hint: String
    var user: Cache.User
    var coordinates : CLLocationCoordinate2D
}

func findCaches(matching partialName: String, in caches: [Cache]) -> [MatchingCache] {
    return caches.filter {
        $0.name.range(of: partialName, options: .caseInsensitive) != nil
    }.map {
        MatchingCache(id: $0.id, name: $0.name, difficulty: $0.difficulty, size: $0.size, description: $0.description, createdAt: $0.createdAt, updatedAt: $0.updatedAt, foundByCurrentUser: $0.foundByCurrentUser, hint: $0.hint, user: $0.user, coordinates: $0.locationCoordinates)
    }
}

func searchCache(searchText: String, modelData: ModelData) -> [MatchingCache] {
    let matchingCaches = findCaches(matching: searchText, in: modelData.caches)
    return matchingCaches
}
