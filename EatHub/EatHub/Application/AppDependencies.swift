//
//  AppDependencies.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

struct AppDependencies {
    let apiRequester: APIRequester
    let mealsService: MealsService

    let homeViewModel: HomeViewModel
    let searchViewModel: SearchViewModel
    let mainViewModel: MainViewModel

    init() {
        self.apiRequester = APIRequester()
        self.mealsService = MealsService(requester: apiRequester)

        self.homeViewModel = HomeViewModel(mealsService: mealsService)
        self.searchViewModel = SearchViewModel(mealService: mealsService)

        self.mainViewModel = MainViewModel(
            homeViewModel: homeViewModel,
            searchViewModel: searchViewModel
        )
    }
}
