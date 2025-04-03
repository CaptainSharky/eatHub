//
//  RandomViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-31.
//

import SwiftUI
import Combine

final class RandomViewModel: ObservableObject {

    enum State: Equatable {
        case loading
        case loaded(Meal)
        case error(String)
    }

    @Published var state: State = .loading
    @Published var isLoading = true

    let detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel
    private let mealService: MealsServiceInterface

    private var cancellable = Set<AnyCancellable>()

    init(
        detailsViewModelBuilder: @escaping ((DetailsViewModuleInput) -> DetailsViewModel),
        mealService: MealsServiceInterface
    ) {
        self.detailsViewModelBuilder = detailsViewModelBuilder
        self.mealService = mealService
    }

    func fetchRandom() {
        withAnimation {
            self.state = .loading
        }
        mealService.fetchRandomMeal()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] meal in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation {
                        self?.state = .loaded(meal)
                    }
                }
            })
            .store(in: &cancellable)
    }

    func makeDetailsViewModel(from meal: Meal) -> DetailsViewModel {
        detailsViewModelBuilder(
            DetailsViewModuleInput(
                id: meal.id,
                name: meal.name,
                thumbnail: meal.thumbnail
            )
        )
    }
}
