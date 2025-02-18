//
//  Recipe.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import Foundation

/*struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    let description: String?  
    let ingredients: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case imageType
        case description
        case ingredients
    }
}*/

struct RandomRecipeResponse: Codable  {
    let recipes: [Recipe]
}




// Убедимся, что Ingredient также соответствует Codable
struct Ingredient: Identifiable, Codable, Hashable{
    let id: Int
    let name: String
    let amount: Double
    let unit: String
    let original: String
}

// Явное добавление соответствия Codable для Recipe
struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let sourceUrl: String
    let summary: String
    let instructions: String
    let extendedIngredients: [Ingredient]

    // Явное добавление ключей для кодирования и декодирования
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case servings
        case readyInMinutes
        case sourceUrl
        case summary
        case instructions
        case extendedIngredients
    }
    
    // Явное декодирование
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        servings = try container.decode(Int.self, forKey: .servings)
        readyInMinutes = try container.decode(Int.self, forKey: .readyInMinutes)
        sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        summary = try container.decode(String.self, forKey: .summary)
        instructions = try container.decode(String.self, forKey: .instructions)
        extendedIngredients = try container.decode([Ingredient].self, forKey: .extendedIngredients)
    }
    
    // Явное кодирование
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(servings, forKey: .servings)
        try container.encode(readyInMinutes, forKey: .readyInMinutes)
        try container.encode(sourceUrl, forKey: .sourceUrl)
        try container.encode(summary, forKey: .summary)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(extendedIngredients, forKey: .extendedIngredients)
    }
    
    func fetchRecipeInformation(recipeId: Int, completion: @escaping (Recipe?) -> Void) {
        // Формируем URL для запроса
        let urlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=95741cb7590f4d44b20a967c125f60b5"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Выполняем сетевой запрос
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching recipe: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                // Декодируем данные в объект типа Recipe
                let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    // Отправляем результат через completion handler
                    completion(recipe)
                }
            } catch {
                print("Error decoding recipe: \(error)")
                completion(nil)
            }
        }.resume()
    }

}



