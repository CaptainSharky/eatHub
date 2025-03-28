//
//  SearchViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [Meal] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let mealService: MealsServiceInterface

    init(mealService: MealsServiceInterface) {
        self.mealService = mealService
    }

    func search() {

    }
}
