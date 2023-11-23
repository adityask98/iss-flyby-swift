//
//  MarkerData.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/23.
//

import Foundation
import Combine

final class MarkerData: ObservableObject {
    @Published var markers: [Marker] = load("markers.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("COULNT FIND")
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("CANNOT PARSE")
        fatalError("Couldn't load/parse \(filename) as \(T.self):\n\(error)")
        
    }
}
