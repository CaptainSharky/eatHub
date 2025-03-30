//
//  MealsResponseModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

struct MealsResponseModel: Decodable {
    let meals: [MealItemResponseModel]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        meals = try container.decodeIfPresent([MealItemResponseModel].self, forKey: .meals) ?? []
    }

    private enum CodingKeys: String, CodingKey {
        case meals
    }
}
