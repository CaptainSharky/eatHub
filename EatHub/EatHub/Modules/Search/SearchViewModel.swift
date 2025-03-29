//
//  SearchViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [Meal] = []

    // TODO: написать обработчик ошибок (возможно в localizable)
    @Published var errorMessage: String?

    var detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel

    private let mealService: MealsServiceInterface
    private var debouncer: Debouncer?
    private var cancellables = Set<AnyCancellable>()

    init(
        detailsViewModelBuilder: @escaping ((DetailsViewModuleInput) -> DetailsViewModel),
        mealService: MealsServiceInterface
    ) {
        self.detailsViewModelBuilder = detailsViewModelBuilder
        self.mealService = mealService
        self.debouncer = Debouncer(timeInterval: 1, handler: { [weak self] in
            self?.search()
        })

        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                guard !newText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                self?.errorMessage = nil
                self?.debouncer?.renewInterval()
            }
            .store(in: &cancellables)
    }

    func search() {
        print("search() запущен с запросом: '\(searchText)'")

        errorMessage = nil

        mealService.searchMeal(name: searchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                    print("Ошибка при поиске: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] meals in
                let limitedMeals = Array(meals.prefix(10))
                self?.results = limitedMeals
            })
            .store(in: &cancellables)
    }
}
