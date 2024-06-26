//
//  SearchLocationViewModel.swift
//  QuickWeather
//
//  Created by Roger Andersen on 25.06.2024.
//

import Foundation
import Combine

class SearchLocationViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var result: OpenMeteoSearchRootDTO? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $text
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { [weak self] newText -> AnyPublisher<OpenMeteoSearchRootDTO?, Error> in
                guard let self = self else { return Just(nil).setFailureType(to: Error.self).eraseToAnyPublisher() }
                self.isLoading = true
                print("searching for \(newText)")
                return self.makeAPICall(with: newText)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.isLoading = false
                self?.result = response
            }
            .store(in: &cancellables)
    }
    
    private func makeAPICall(with text: String) -> AnyPublisher<OpenMeteoSearchRootDTO?, Error> {
        guard let url = URL(string: "https://geocoding-api.open-meteo.com/v1/search?name=\(text)&count=10&language=en&format=json") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> OpenMeteoSearchRootDTO? in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                let result = try JSONDecoder().decode(OpenMeteoSearchRootDTO.self, from: data)
                return result
               
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
