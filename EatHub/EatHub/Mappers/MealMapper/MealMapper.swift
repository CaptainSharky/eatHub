//
//  MealMapper.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

extension MealsResponseModel {
    func mapToMealList() -> [Meal] {
        return meals.compactMap { $0.mapToMeal() }
    }
}

// MARK: - [MealItemResponseModel]

extension Array where Element == MealItemResponseModel {
    func mapToMealList() -> [Meal] {
        self.compactMap { $0.mapToMeal() }
    }
}

// MARK: - MealItemResponseModel

extension MealItemResponseModel {
    func mapToMeal() -> Meal {
        Meal(
            id: self.idMeal ?? "",
            name: self.strMeal ?? "",
            category: self.strCategory,
            instructions: self.strInstructions,
            thumbnail: self.strMealThumb,
            tags: self.strTags,
            youtube: self.strYoutube,
            ingredients: self.ingredients.compactMap{
                Ingredient(name: $0.name, measure: $0.measure)
            }
        )
    }
}
