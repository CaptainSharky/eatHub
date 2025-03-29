//
//  AppDependencies.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

struct AppDependencies {
    let mealsService: MealsService

    let homeViewModel: HomeViewModel
    let searchViewModel: SearchViewModel
    let mainViewModel: MainViewModel
    let favoriteViewModel: FavoriteViewModel

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

        let homeViewModel = HomeViewModel(
            detailsViewModelBuilder: detailsViewModelBuilder,
            mealsService: mealsService
        )
        self.homeViewModel = homeViewModel

        let searchViewModel = SearchViewModel(
            detailsViewModelBuilder: detailsViewModelBuilder,
            mealService: mealsService
        )
        self.searchViewModel = searchViewModel

        let favoriteViewModel = FavoriteViewModel()
        self.favoriteViewModel = favoriteViewModel

        mainViewModel = MainViewModel(
            homeViewModel: homeViewModel,
            searchViewModel: searchViewModel,
            favoriteViewModel: favoriteViewModel
        )
    }
}
