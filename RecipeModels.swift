//
//  Recipe.swift
//  TastyHub
//
//  Created by Роман  on 15.01.2025.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
    let preparationTime: String
    let category: String
}






