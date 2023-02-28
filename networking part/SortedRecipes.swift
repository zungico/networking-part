//
//  SortedRecipes.swift
//  networking part
//
//  Created by Вова on 28.02.2023.
//

import Foundation

struct SortedRecipes: Codable {
    let results: [Recipe]
}

struct Recipe: Codable {
    let id : Int

}
