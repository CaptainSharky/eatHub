//
//  AppDependencies.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

struct AppDependencies {

    let mealsService: MealsService
    let detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel

    init() {
        let apiRequester = APIRequester()
        let mealsService = MealsService(requester: apiRequester)
        self.mealsService = mealsService

        let detailsViewModelBuilder: ((DetailsViewModuleInput) -> DetailsViewModel) = { input in
            DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                mealsService: mealsService
            )
        }
        self.detailsViewModelBuilder = detailsViewModelBuilder
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(detailsViewModelBuilder: detailsViewModelBuilder, mealsService: mealsService)
    }

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(detailsViewModelBuilder: detailsViewModelBuilder, mealService: mealsService)
    }

    func makeFavoriteViewModel() -> FavoriteViewModel {
        FavoriteViewModel()
    }
}
