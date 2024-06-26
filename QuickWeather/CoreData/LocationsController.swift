//
//  LocationsController.swift
//  QuickWeather
//
//  Created by Roger Andersen on 26.06.2024.
//

import Foundation
import CoreData

class LocationsController: ObservableObject {
    let container = NSPersistentContainer(name: "Locations")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
