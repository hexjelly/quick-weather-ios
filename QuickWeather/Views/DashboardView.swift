//
//  DashboardView.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardListViewModel()
    @StateObject private var searchViewModel = SearchLocationViewModel()
    
    var body: some View {
        VStack {
            TextField(
                "Enter location",
                text: $searchViewModel.text
            ).onSubmit {
//                viewModel.addLocation()
            }
            
            List(viewModel.locations) { location in
                Text(location.name)
            }
            
            List(searchViewModel.result?.results ?? []) { result in
                Text(result.name)
            }
        }
    }
}

#Preview {
    DashboardView()
}
