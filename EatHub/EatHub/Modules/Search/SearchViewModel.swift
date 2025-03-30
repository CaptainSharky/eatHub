//
//  SearchViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {

    private enum Constants {
        static let debounceInterval: TimeInterval = 1
        static let limitCount: Int = 15
    }

    enum State {
        case idle
        case emptyResults
        case resultsLoaded([Meal])
        case error(Error)
    }

    @Published var searchText: String = ""
    @Published var results: [Meal] = []
    @Published var state: State = .idle

    private let mealService: MealsServiceInterface
    private var debouncer: Debouncer?
    private var cancellables = Set<AnyCancellable>()

    init(mealService: MealsServiceInterface) {
        self.mealService = mealService
        self.debouncer = Debouncer(
            timeInterval: Constants.debounceInterval,
            handler: { [weak self] in
                self?.search()
            }
        )

        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                guard !newText.trimmingCharacters(in: .whitespaces).isEmpty else {
                    self?.state = .idle
                    return
                }
                self?.debouncer?.renewInterval()
            }
            .store(in: &cancellables)
    }

    func search() {
        state = .idle
        mealService.searchMeal(name: searchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] meals in
                let limitedMeals = Array(meals.prefix(Constants.limitCount))
                self?.results = limitedMeals
                self?.state = limitedMeals.isEmpty ? .emptyResults : .resultsLoaded(limitedMeals)
            })
            .store(in: &cancellables)
    }
}
