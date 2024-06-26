//
//  LocationsControllerMock.swift
//  QuickWeather
//
//  Created by Roger Andersen on 26.06.2024.
//

import Foundation
import SwiftUI
import CoreData

struct LocationsControllerMock {
    static let shared = LocationsControllerMock()

    static var preview: LocationsControllerMock = {
        let result = LocationsControllerMock(inMemory: true)
        let viewContext = result.container.viewContext

        for _ in 0..<5 {
            let location = Location(context: viewContext)
            location.id = UUID()
            location.name = "Test"
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Locations")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
