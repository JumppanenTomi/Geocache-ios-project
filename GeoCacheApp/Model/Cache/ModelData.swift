//
//  ModelData.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//

import Foundation
import Combine

final class ModelData: ObservableObject{
    @Published var caches: [Cache] = load("cacheData.json")
}

var caches: [Cache] = load("cacheData.json")

func load<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't find \(filename) from main bundle:\n\(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Could't parse \(filename) as \(T.self):\n\(error)")
    }
}
