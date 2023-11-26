//
//  List.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import Foundation


struct Item: Hashable, Codable{
    var title: String = ""
    var description: ISSSighting
    
}
      
struct ISSSighting: Hashable, Codable {
    var date: String = ""
    var time: String = ""
    var duration: String = ""
    var maxElevation: String = ""
    var approach: String = ""
    var departure: String = ""
}

func extractSightingInfo(from description: String) -> ISSSighting? {
    print(description)
    var sighting = ISSSighting()

    let pattern = "(\\w+): (.*?)<br/>"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])

    let matches = regex.matches(in: description, options: [], range: NSRange(location: 0, length: description.utf16.count))

    for match in matches {
        guard
            let keyRange = Range(match.range(at: 1), in: description),
            let valueRange = Range(match.range(at: 2), in: description)
        else { continue }

        let key = String(description[keyRange])
        let value = String(description[valueRange])

        switch key {
        case "Date":
            sighting.date = value
        case "Time":
            sighting.time = value
        case "Duration":
            sighting.duration = value
        case "Maximum Elevation":
            sighting.maxElevation = value
        case "Approach":
            sighting.approach = value
        case "Departure":
            sighting.departure = value
        default:
            break
        }
    }

    return sighting
}
