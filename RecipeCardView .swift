//
//  RecipeCardView .swift
//  TastyHub
//
//  Created by Роман  on 17.02.2025.
//

import SwiftUI

struct RecipeCardItemView: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFit().frame(height: 150)
                } else if phase.error != nil {
                    Color.red.frame(height: 150)
                } else {
                    ProgressView().frame(height: 150)
                }
            }
            Text(recipe.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding([.top, .horizontal])
            Text(recipe.description ?? "Нет описания")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding([.horizontal, .bottom])
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
