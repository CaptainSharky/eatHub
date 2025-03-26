//
//  MealItemRespoonseModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

struct MealItemResponseModel: Decodable {

    let idMeal: String?
    let strArea: String?
    let strCategory: String?
    let strInstructions: String?
    let strMeal: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let ingredients: [IngredientResponseModel]

    enum CodingKeys: String, CodingKey {
        case idMeal, strArea, strCategory, strInstructions, strMeal, strMealThumb, strTags, strYoutube
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var ingredientResponse: [IngredientResponseModel] = []
        for index in 1...20 {
            guard let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)"),
                  let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)")
            else {
                continue
            }

            let ingredientName = try dynamicContainer.decodeIfPresent(
                String.self,
                forKey: ingredientKey
            )?.trimmingCharacters(in: .whitespacesAndNewlines)

            if let ingredientName = ingredientName, !ingredientName.isEmpty {
                let measure = try dynamicContainer.decodeIfPresent(
                    String.self,
                    forKey: measureKey
                )?.trimmingCharacters(in: .whitespacesAndNewlines)

                ingredientResponse.append(IngredientResponseModel(name: ingredientName, measure: measure))
            }
        }
        ingredients = ingredientResponse
    }
}

// MARK: - DynamicCodingKeys

fileprivate struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int? { return nil }

    // MARK: Lifecycle

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}
