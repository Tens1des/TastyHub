//
//  Recipe.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import Foundation

struct Recipe: Identifiable, Codable {
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
}






