//
//  AppDependencies.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

struct AppDependencies {

    let mealsService: MealsServiceInterface
    let detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel
    let launchScreenStateManager: LaunchScreenStateManager
    let favoritesManager: FavoritesManagerInterface

    init() {
        let apiRequester = APIRequester()
        let favoritesManager = FavoritesManager(store: UserDefaults.standard)
        let mealsService = MealsService(requester: apiRequester)

        let detailsViewModelBuilder: ((DetailsViewModuleInput) -> DetailsViewModel) = { input in
            DetailsViewModel(
                id: input.id,
                name: input.name,
                thumbnail: input.thumbnail,
                favoritesManager: favoritesManager,
                mealsService: mealsService
            )
        }

        self.mealsService = mealsService
        self.favoritesManager = favoritesManager
        self.detailsViewModelBuilder = detailsViewModelBuilder
        self.launchScreenStateManager = LaunchScreenStateManager()
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(detailsViewModelBuilder: detailsViewModelBuilder, mealsService: mealsService)
    }

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(detailsViewModelBuilder: detailsViewModelBuilder, mealService: mealsService)
    }

    func makeFavoriteViewModel() -> FavoriteViewModel {
        FavoriteViewModel(
            favoritesManager: favoritesManager,
            mealsService: mealsService,
            detailsViewModelBuilder: detailsViewModelBuilder
        )
    }

    func makeRandomViewModel() -> RandomViewModel {
        RandomViewModel(detailsViewModelBuilder: detailsViewModelBuilder, mealService: mealsService)
    }
}
