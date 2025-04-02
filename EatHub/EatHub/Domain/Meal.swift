//
//  Meal.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

struct Meal: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let category: String?
    let instructions: String?
    let thumbnail: String?
    let area: String?
    let tags: String?
    let youtube: String?
    let ingredients: [Ingredient]
}
