//
//  RecipeListView.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil

    let categories = ["Все", "Завтрак", "Обед", "Ужин"]

    var body: some View {
        NavigationView {
            VStack {
                TextField("Искать рецепты...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category == "Все" ? nil : category
                            }) {
                                Text(category)
                                    .padding()
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                List(filteredRecipes) { recipe in
                    HStack {
                        AsyncImage(url: URL(string: recipe.image)) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit().frame(width: 50, height: 50)
                            } else if phase.error != nil {
                                Color.red.frame(width: 50, height: 50)
                            } else {
                                ProgressView().frame(width: 50, height: 50)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.headline)
                            Text("Время: \(recipe.preparationTime)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Button(action: {
                    print("Добавить новый рецепт")
                }) {
                    Text("Добавить рецепт")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .onAppear {
                viewModel.loadRecipes()
            }
            .navigationTitle("Рецепты")
        }
    }

    private var filteredRecipes: [Recipe] {
        viewModel.recipes.filter { recipe in
            let matchesSearchText = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || recipe.category == selectedCategory
            return matchesSearchText && matchesCategory
        }
    }
}
