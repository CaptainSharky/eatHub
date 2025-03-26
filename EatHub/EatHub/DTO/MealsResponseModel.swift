//
//  MealsResponseModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

struct MealsResponseModel: Decodable {
    let meals: [MealItemResponseModel]?
}
