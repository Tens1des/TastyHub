//
//  RecipeDetailView.swift
//  TastyHub
//
//  Created by Роман  on 17.02.2025.
//

import SwiftUI
import Foundation


struct RecipeDetailViewPage: View {
    var recipeId: Int // Параметр для id рецепта
    @State private var recipe: Recipe?

    var body: some View {
        VStack(alignment: .leading) {
            if let recipe = recipe {
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit().frame(height: 250)
                    } else if phase.error != nil {
                        Color.red.frame(height: 250)
                    } else {
                        ProgressView().frame(height: 250)
                    }
                }

                Text(recipe.title)
                    .font(.title)
                    .padding()

                Text("Ингредиенты:")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(recipe.extendedIngredients, id: \.id) { ingredient in
                    Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                        .padding(.horizontal)
                }

                Spacer()
            } else {
                ProgressView("Загрузка...").padding()
            }
        }
        .navigationTitle("Рецепт")
        /*.onAppear {
            fetchRecipeInformation(recipeId: recipeId) { fetchedRecipe in
                self.recipe = fetchedRecipe // Обновляем состояние с полученными данными
            }
        }*/
    }
}


  

