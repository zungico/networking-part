//
//  Recipe.swift
//  networking part
//
//  Created by Вова on 27.02.2023.
//

import Foundation

struct popularRecipeResponce: Codable {
    let recipes: [Recipe]
}
struct Recipe: Codable {
    let id: Int
    let readyInMinutes: Int?
    let title: String?
    let image: String?
    let aggregateLikes: Int?
    let extendedIngredients: [ExtendedIngredient]
}

struct ExtendedIngredient: Codable {
    let image: String?
    let name: String?
    let amount: Double?
    let unit: String?
    let summary: String?
    let instructions: String?
}
