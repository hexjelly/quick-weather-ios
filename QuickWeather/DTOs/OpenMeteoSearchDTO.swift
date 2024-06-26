//
//  OpenMeteoSearchDTO.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import Foundation

struct OpenMeteoSearchRootDTO: Decodable {
    var results: [OpenMeteoSearchItemDTO]
}

struct OpenMeteoSearchItemDTO: Decodable, Identifiable {
    var id: Int
    var name: String
    var latitude: Float64
    var longitude: Float64
    var elevation: Float64
    var country_code: String
    var country: String
}
