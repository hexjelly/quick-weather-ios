//
//  QuickWeatherApp.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import SwiftUI

@main
struct QuickWeatherApp: App {
    @StateObject private var locationsController = LocationsController()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.managedObjectContext, locationsController.container.viewContext)
        }
    }
}
