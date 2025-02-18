//
//  RecipeListViewModel.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import SwiftUI


class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []

    func loadRandomRecipes() {
        SpoonacularAPIService.shared.fetchRandomRecipes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                case .failure(let error):
                    print("❌ Ошибка загрузки случайных рецептов: \(error.localizedDescription)")
                }
            }
        }
    }
}


