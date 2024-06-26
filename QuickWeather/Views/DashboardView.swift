//
//  DashboardView.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @StateObject private var viewModel = DashboardListViewModel()
    @StateObject private var searchViewModel = SearchLocationViewModel()
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<Location>
    @Environment(\.managedObjectContext) private var moc
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Locations")
                ClickableReadOnlyTextField(placeholder: "Search...", action: {
                    isShowingSheet.toggle()
                })                
            }
            
            List(locations) { location in
                Text(location.name ?? "Unknown")
            }
            
            .sheet(isPresented: $isShowingSheet) {
                SearchLocation()
            }
        }
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, LocationsControllerMock.preview.container.viewContext)
}
