//
//  RecipeListView.swift
//  TastyHub
//
//  Created by Роман  on 31.01.2025.
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
                // Поле поиска
                TextField("Искать рецепты...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)

                // Секция с категориями
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category == "Все" ? nil : category
                            }) {
                                Text(category)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .animation(.spring(), value: selectedCategory)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Ошибки
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                // Список рецептов
                ScrollView {
                    LazyVStack {
                        ForEach(filteredRecipes) { recipe in
                            RecipeCard(recipe: recipe)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                }

                // Кнопка добавления рецепта
                Button(action: {
                    print("Добавить новый рецепт")
                }) {
                    Text("Добавить рецепт")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                }
                .padding(.bottom)
            }
            .onAppear {
                viewModel.loadRecipes()
            }
            .navigationTitle("Рецепты")
        }
    }

    // Фильтрация рецептов по категории и поиску
    private var filteredRecipes: [Recipe] {
        viewModel.recipes.filter { recipe in
            let matchesSearchText = searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || recipe.category == selectedCategory
            return matchesSearchText && matchesCategory
        }
    }
}

struct RecipeCard: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            // Картинка рецепта
            AsyncImage(url: URL(string: recipe.image)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .cornerRadius(15)
                        .clipped()
                } else if phase.error != nil {
                    Color.red.frame(height: 200).cornerRadius(15)
                } else {
                    ProgressView().frame(height: 200)
                }
            }

            // Информация о рецепте
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)

                Text("Время: \(recipe.preparationTime) минут")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

