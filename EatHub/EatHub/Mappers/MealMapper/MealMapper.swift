//
//  MealMapper.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

struct MealsMapper {
    static func mapMealsResponse(_ response: MealsResponseModel) -> [Meal] {
        guard let meals = response.meals else { return [] }
        return meals.compactMap { mapMeal(from: $0) }
    }

    static func mapMealItemResponse(_ response: MealItemResponseModel) -> Meal? {
        mapMeal(from: response)
    }

    static func mapMealItemResponseToList(_ response: [MealItemResponseModel]) -> [Meal] {
        response.compactMap { mapMeal(from: $0) }
    }
}

// MARK: - Private methods

private extension MealsMapper {
    static func mapMeal(from response: MealItemResponseModel) -> Meal {
        Meal(
            id: response.idMeal ?? "",
            name: response.strMeal ?? "",
            category: response.strCategory,
            instructions: response.strInstructions,
            thumbnail: response.strMealThumb,
            tags: response.strTags,
            youtube: response.strYoutube,
            ingredients: response.ingredients.compactMap{
                Ingredient(name: $0.name, measure: $0.measure)
            }
        )
    }
}
