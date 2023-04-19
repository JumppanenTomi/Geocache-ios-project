import Foundation
import Combine
import CoreLocation

struct MatchingCache {
    let id: Int
    let name: String
}

func findCaches(matching partialName: String, in caches: [Cache]) -> [MatchingCache] {
    return caches.filter {
        $0.name.range(of: partialName, options: .caseInsensitive) != nil
    }.map {
        MatchingCache(id: $0.id, name: $0.name)
    }
}

func searchCache(searchText: String) -> [MatchingCache] {
    let modelData = ModelData()
    let matchingCaches = findCaches(matching: searchText, in: modelData.caches)
    return matchingCaches
}
