//
//  AppDependencies.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

struct AppDependencies {
    let mealsService: MealsService

    init() {
        let apiRequester = APIRequester()
        self.mealsService = MealsService(requester: apiRequester)
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(mealsService: mealsService)
    }

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(mealService: mealsService)
    }

    func makeFavoriteViewModel() -> FavoriteViewModel {
        FavoriteViewModel()
    }
}
