//
//  Location.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import Foundation

struct Location: Hashable, Identifiable {
    var id = UUID()
    var name: String
}
