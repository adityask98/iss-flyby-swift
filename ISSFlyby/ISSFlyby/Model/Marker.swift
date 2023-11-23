//
//  Marker.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/23.
//

import Foundation


struct Marker: Hashable, Codable {
    var id = UUID().uuidString
    var name: String
    var latitude: Double
    var longitude: Double
    var additional_info: String
    var country: String
    var city_identifier: String
    
    enum CodingKeys: CodingKey {
        case name
        case latitude
        case longitude
        case additional_info
        case country
        case city_identifier
    }
}
