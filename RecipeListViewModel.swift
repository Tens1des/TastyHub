//
//  RecipeListViewModel.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import SwiftUI

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String? = nil 

    func loadRecipes() {
        SpoonacularAPIService.shared.searchRecipes(query: "pasta") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.recipes = recipes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

