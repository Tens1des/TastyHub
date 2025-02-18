//
//  RecipeAPIService.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import Foundation

class SpoonacularAPIService {
    static let shared = SpoonacularAPIService()
    private let apiKey = "95741cb7590f4d44b20a967c125f60b5" 

    private init() {}

    func searchRecipes(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&number=10&apiKey=\(apiKey)"
        
        print("Выполняем запрос к API \(urlString)")
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка при выполнении запроса \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Нет данных в ответе")
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                print("Получены данные \(String(data: data, encoding: .utf8) ?? "Ошибка декодирования данных")")
                let decodedResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                print("Ошибка при декодировании данных \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchRandomRecipes(number: Int = 10, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/random?number=20&apiKey=95741cb7590f4d44b20a967c125f60b5"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        print("📡 Выполняем запрос к API: \(urlString)")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Ошибка при запросе: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("❌ Ошибка: пустые данные")
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RandomRecipeResponse.self, from: data)
                print("✅ Успешно получены рецепты: \(decodedResponse.recipes.count)")
                completion(.success(decodedResponse.recipes))
            } catch {
                print("❌ Ошибка декодирования: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    

    // Объявление функции fetchRecipeInformation
    func fetchRecipeInformation(recipeId: Int, completion: @escaping (Recipe) -> Void) {
        // Создаем URL для получения информации о рецепте
        let urlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=YOUR_API_KEY"
        
        guard let url = URL(string: urlString) else { return }
        
        // Выполняем запрос
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching recipe: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                // Декодируем ответ в объект типа Recipe
                let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedRecipe) // Передаем результат в completion handler
                }
            } catch {
                print("Error decoding recipe: \(error)")
            }
        }.resume()
    }


    
}


struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}

/*func fetchRandomRecipes(number: Int = 10, completion: @escaping (Result<[Recipe], Error>) -> Void) {
    let urlString = "https://api.spoonacular.com/recipes/random?number=20&apiKey=95741cb7590f4d44b20a967c125f60b5"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
        return
    }

    print("📡 Выполняем запрос к API: \(urlString)")

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("❌ Ошибка при запросе: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }

        guard let data = data else {
            print("❌ Ошибка: пустые данные")
            completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
            return
        }

        do {
            let decodedResponse = try JSONDecoder().decode(RandomRecipeResponse.self, from: data)
            print("✅ Успешно получены рецепты: \(decodedResponse.recipes.count)")
            completion(.success(decodedResponse.recipes))
        } catch {
            print("❌ Ошибка декодирования: \(error)")
            completion(.failure(error))
        }
    }

    task.resume()
}*/

