//
//  APIProvider.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

enum APIProvider {

    /// Search meal by name
    case searchMeal(name: String)

    /// Lookup full meal details by id
    case mealDetails(id: String)

    /// Lookup a single random meal
    case randomMeal

    ///Lookup a selection of 10 random meals
    case randomSelection

    /// List all meal categories
    case categories

    /// Latest Meals
    case latestMeals
}
