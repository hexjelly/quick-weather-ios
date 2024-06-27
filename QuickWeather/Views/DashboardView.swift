//
//  DashboardView.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import CoreData
import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardListViewModel()
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<Location>
    @Environment(\.managedObjectContext) private var moc
    
    @State private var isShowingSheet = false

    var body: some View {
        VStack {
            ClickableReadOnlyTextField(
                placeholder: String(localized: "search_placeholder"),
                action: {
                    isShowingSheet.toggle()
                }
            )
            .padding(.horizontal, 10)
            .opacity(isShowingSheet ? 0 : 1)

            VStack {
                List(locations) { location in
                    Text(location.name ?? "Unknown")
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            SearchLocation()
        }
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, LocationsControllerMock.preview.container.viewContext)
}
