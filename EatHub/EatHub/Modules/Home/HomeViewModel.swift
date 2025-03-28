//
//  MainViewModal.swift
//  EatHub
//
//  Created by Даниил Дементьев on 26.03.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var horizontalMeals: [Meal] = []
    @Published var verticalMeals: [Meal] = []
    @Published var errorMessage: String?

    private let mealsService: MealsServiceInterface
    private var cancellables = Set<AnyCancellable>()

    init(mealsService: MealsServiceInterface) {
        self.mealsService = mealsService
    }

    func fetchMeals() {
        errorMessage = nil

        mealsService.fetchLatestMeals()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] meals in
                self?.horizontalMeals = meals
            })
            .store(in: &cancellables)

        mealsService.fetchRandomSelection()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] meals in
                self?.verticalMeals = Array(meals.prefix(10))
            })
            .store(in: &cancellables)
    }
}
