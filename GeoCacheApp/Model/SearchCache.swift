import Foundation
import Combine
import CoreLocation

struct MatchingCache {
    var id: Int
    var name: String
    var difficulty: Int
    var size: Int
    var author: String
    var isFeatured: Bool
    var description: String
    var coordinates: Cache.Coordinates
}

func findCaches(matching partialName: String, in caches: [Cache]) -> [MatchingCache] {
    return caches.filter {
        $0.name.range(of: partialName, options: .caseInsensitive) != nil
    }.map {
        MatchingCache(id: $0.id, name: $0.name, difficulty: $0.difficulty, size: $0.size, author: $0.author, isFeatured: $0.isFeatured, description: $0.description, coordinates: Cache.Coordinates(latitude: $0.locationCoordinates.latitude, longitude: $0.locationCoordinates.longitude))
    }
}

func searchCache(searchText: String) -> [MatchingCache] {
    let modelData = ModelData()
    let matchingCaches = findCaches(matching: searchText, in: modelData.caches)
    return matchingCaches
}
