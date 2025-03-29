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

    private let mealService: MealsServiceInterface
    private var debouncer: Debouncer?
    private var cancellables = Set<AnyCancellable>()

    init(mealService: MealsServiceInterface) {
        self.mealService = mealService
        self.debouncer = Debouncer(timeInterval: 0.5, handler: { [weak self] in
//            print("debounce сработал, вызываем search()")
            self?.search()
        })

        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                guard !newText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//                print("$searchText получил новое значение: \(newText)")
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
//                print("Найдено рецептов: \(limitedMeals)")
            })
            .store(in: &cancellables)
    }
}
