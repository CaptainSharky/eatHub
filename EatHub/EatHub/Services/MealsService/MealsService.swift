//
//  MealsService.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Foundation
import Combine

final class MealsService {
    // MARK: Private properties

    private let requester: Requestable

    // MARK: Lifecycle

    init(requester: Requestable) {
        self.requester = requester
    }
}

// MARK: - MealsServiceInterface

extension MealsService: MealsServiceInterface {
    func searchMeal(name: String) -> AnyPublisher<[Meal], Error> {
        requester.searchMeal(name: name)
            .tryMap { response in
                response.mapToMealList()
            }
            .eraseToAnyPublisher()
    }

    func fetchMeal(id: String) -> AnyPublisher<Meal, Error> {
        requester.lookupMeal(id: id)
            .map { $0.mapToMeal() }
            .eraseToAnyPublisher()
    }

    func fetchRandomMeal() -> AnyPublisher<Meal, Error> {
        requester.randomMeal()
            .tryMap { response in
                guard let firstMeal = response.meals?.first else {
                    throw NSError(domain: "MappingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No meal found"])
                }
                return firstMeal.mapToMeal()
            }
            .eraseToAnyPublisher()
    }

    func fetchRandomSelection() -> AnyPublisher<[Meal], Error> {
        requester.randomSelection()
            .tryMap { $0.mapToMealList() }
            .eraseToAnyPublisher()
    }

    func fetchLatestMeals() -> AnyPublisher<[Meal], Error> {
        requester.latestMeals()
            .tryMap { $0.mapToMealList() }
            .eraseToAnyPublisher()
    }
}
