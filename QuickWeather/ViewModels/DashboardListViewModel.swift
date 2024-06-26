//
//  DashboardListViewModel.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import Foundation

class DashboardListViewModel: ObservableObject {
    @Published var locations: [Location] = []
    
    func addLocation(location: String) {
        locations.append(Location(name: location))
    }
}
