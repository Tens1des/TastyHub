//
//  RecipeListView.swift
//  TastyHub
//
//  Created by Роман  on 31.01.2025.
//

import SwiftUI


struct RecipeListView: View {
    @ObservedObject var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeCardView(recipe: recipe)
                }
            }
            .onAppear {
                viewModel.loadPopularRecipes()  
            }
            .navigationTitle("Популярные рецепты")
        }
    }
}

struct RecipeCardView: View {
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

struct RecipeDetailView: View {
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
