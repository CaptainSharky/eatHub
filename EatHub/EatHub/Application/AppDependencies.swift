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
        self.mealsService = MealsService(requester: apiRequester)

        self.homeViewModel = HomeViewModel(mealsService: mealsService)
        self.searchViewModel = SearchViewModel(mealService: mealsService)
        self.favoriteViewModel = FavoriteViewModel()

        self.mainViewModel = MainViewModel(
            homeViewModel: homeViewModel,
            searchViewModel: searchViewModel,
            favoriteViewModel: favoriteViewModel
        )
    }
}
