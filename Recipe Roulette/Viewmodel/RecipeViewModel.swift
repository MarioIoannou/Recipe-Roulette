//
//  RecipeViewModel.swift
//  Recipe Roulette
//
//  Created by Marios Ioannou on 22/10/24.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    @Published var selectedRecipe: Recipe? = nil
    @Published var filters = RecipeFilters()
    
    private var cancellable: AnyCancellable?
    
    func fetchRandomRecipe() {
        var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/random")!
        var queryItems = [
            URLQueryItem(name: "number", value: "1"),
            URLQueryItem(name: "apiKey", value: "ee56fac6cbd441b58819019ba7713f84")
        ]
        
        if !filters.dietaryRestrictions.isEmpty {
            let tags = filters.dietaryRestrictions.joined(separator: ",")
            queryItems.append(URLQueryItem(name: "include-tags", value: tags.lowercased()))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        print("Request URL: \(url)")
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RecipeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully fetched recipe.")
                case .failure(let error):
                    print("Error fetching recipe: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.selectedRecipe = response.recipes.first
            })
    }
}
