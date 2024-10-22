//
//  Recipe.swift
//  Recipe Roulette
//
//  Created by Marios Ioannou on 22/10/24.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String?
    let instructions: String?
    let extendedIngredients: [Ingredient]
}

struct Ingredient: Codable, Identifiable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
}
