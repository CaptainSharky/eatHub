//
//  DetailsViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import Combine
import SwiftUICore

final class DetailsViewModel: ObservableObject {
    let id: String

    @Published var name: String?
    @Published var thumbnail: String?
    @Published var category: String?
    @Published var area: String?
    @Published var tagsChips: [ChipsViewModel]
    @Published var instructions: String?
    @Published var ingredients: [Ingredient]
    @Published var youtubeURL: URL?

    @Published var isCloseButtonHidden: Bool
    @Published var isSkeletonable: Bool

    var isLiked: Bool {
        favoritesManager?.isFavorite(mealID: id) ?? false
    }

    var verticalItemViewModel: VerticalItemViewModel {
        VerticalItemViewModel(
            id: self.id,
            name: self.name,
            thumbnail: self.thumbnail,
            category: self.category,
            area: self.area
        )
    }

    private let favoritesManager: FavoritesManagerInterface?
    private let mealsService: MealsServiceInterface?
    private var cancellables = Set<AnyCancellable>()

    init(
        id: String,
        name: String? = nil,
        thumbnail: String? = nil,
        category: String? = nil,
        area: String? = nil,
        tagsChips: [ChipsViewModel] = [],
        instructions: String? = nil,
        ingredients: [Ingredient] = [],
        youtubeURL: URL? = nil,
        favoritesManager: FavoritesManagerInterface?,
        mealsService: MealsServiceInterface?,
        isCloseButtonHidden: Bool = false,
        isSkeletonable: Bool = true
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.category = category
        self.area = area
        self.tagsChips = tagsChips
        self.instructions = instructions
        self.ingredients = ingredients
        self.youtubeURL = youtubeURL
        self.favoritesManager = favoritesManager
        self.mealsService = mealsService
        self.isCloseButtonHidden = isCloseButtonHidden
        self.isSkeletonable = isSkeletonable
    }

    func fetchMeal() {
        isSkeletonable = true

        cancellables.removeAll()

        mealsService?.fetchMeal(id: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] meal in
                    guard let self else { return }
                    guard let meal else { return }

                    name = meal.name
                    thumbnail = meal.thumbnail
                    category = meal.category
                    area = meal.area
                    tagsChips = makeChipsViewModels(tags: meal.tags)
                    instructions = meal.instructions
                    ingredients = meal.ingredients
                    youtubeURL = makeYouTubeURL(from: meal.youtube)

                    isSkeletonable = false
                }
            )
            .store(in: &cancellables)
    }

    func updateMealInFavorites(isLiked: Bool) {
        if isLiked {
            favoritesManager?.add(mealID: id)
        } else {
            favoritesManager?.remove(mealID: id)
        }
    }
}

private extension DetailsViewModel {
    func makeChipsViewModels(tags: String?) -> [ChipsViewModel] {
        guard let tags = tags else { return [] }
        let separatedTags = tags.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        return separatedTags.map { ChipsViewModel(text: $0) }
    }

    func makeYouTubeURL(from youtubeString: String?) -> URL? {
        guard let youtubeString = youtubeString else { return nil }
        return URL(string: youtubeString)
    }
}
