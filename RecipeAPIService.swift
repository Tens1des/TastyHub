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
}


struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}


