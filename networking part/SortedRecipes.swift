//
//  SortedRecipes.swift
//  networking part
//
//  Created by Вова on 28.02.2023.
//

import Foundation

struct SortedRecipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id : Int
    let title: String?
    let image: String?
}
