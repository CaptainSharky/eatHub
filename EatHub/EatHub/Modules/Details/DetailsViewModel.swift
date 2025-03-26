//
//  DetailsViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUICore

final class DetailsViewModel: ObservableObject {
    let title: String
    let image: Image?
    let category: String?
    let area: String?
    let tagsChips: [ChipsViewModel]
    let instructions: String?
    let ingredients: [Ingredient]
    let youtubeURL: URL?

    init(
        title: String,
        image: Image? = nil,
        category: String? = nil,
        area: String? = nil,
        tagsChips: [ChipsViewModel] = [],
        instructions: String? = nil,
        ingredients: [Ingredient] = [],
        youtubeURL: URL? = nil
    ) {
        self.title = title
        self.image = image
        self.category = category
        self.area = area
        self.tagsChips = tagsChips
        self.instructions = instructions
        self.ingredients = ingredients
        self.youtubeURL = youtubeURL
    }
}
