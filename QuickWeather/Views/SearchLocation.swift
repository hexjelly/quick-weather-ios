//
//  SearchLocation.swift
//  QuickWeather
//
//  Created by Roger Andersen on 26.06.2024.
//

import SwiftUI

struct SearchLocation: View {
    @StateObject private var searchViewModel = SearchLocationViewModel()
    @FocusState private var isFocused: Bool

    private func getFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map { 127397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }

    var body: some View {
        VStack {
            TextField(
                "",
                text: $searchViewModel.text,
                prompt: Text("Enter location").foregroundColor(.secondary)
            ).padding(.horizontal, 20)
                .padding(.bottom, 10)
                .background(Color.secondary).foregroundColor(.black).focused($isFocused)

            List(searchViewModel.result?.results ?? []) { result in
                HStack {
                    Text(getFlag(from: result.country_code))
                    Text(result.name)
                    Text(result.country)
                }
            }
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isFocused = true
                    }
                }
    }
}

#Preview {
    SearchLocation()
}
