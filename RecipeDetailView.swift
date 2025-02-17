//
//  RecipeDetailView.swift
//  TastyHub
//
//  Created by Роман  on 17.02.2025.
//

import SwiftUI

struct RecipeDetailViewPage: View {
    var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
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

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text(ingredient)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle(recipe.title)
    }
}
