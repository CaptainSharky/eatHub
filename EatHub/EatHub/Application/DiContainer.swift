//
//  DiContainer.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()

    // MARK: - Services
    lazy var apiRequester = APIRequester()
    lazy var mealsService = MealsService(requester: apiRequester)

    // MARK: - ViewModels
    lazy var homeViewModel = HomeViewModel(mealsService: mealsService)
    lazy var searchViewModel = SearchViewModel(mealService: mealsService)
    lazy var mainViewModel = MainViewModel(
        homeViewModel: homeViewModel,
        searchViewModel: searchViewModel
    )

    private init() {}
}
