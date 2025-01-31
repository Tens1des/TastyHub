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
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}


struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}


