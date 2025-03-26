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

    private func mapMeal(from response: MealItemResponseModel) throws -> Meal {
        guard let meal = MealsMapper.mapMealItemResponse(response) else {
            throw NSError(domain: "MappingError", code: 0, userInfo: nil)
        }
        return meal
    }
}

// MARK: - MealsServiceInterface

extension MealsService: MealsServiceInterface {
    func searchMeal(name: String) -> AnyPublisher<[Meal], Error> {
        requester.searchMeal(name: name)
            .tryMap { response in
                MealsMapper.mapMealsResponse(response)
            }
            .eraseToAnyPublisher()
    }

    func fetchMeal(id: String) -> AnyPublisher<Meal, Error> {
        requester.lookupMeal(id: id)
            .tryMap { [weak self] response in
                guard let self = self else {
                    throw NSError(domain: "Self is nil", code: 0, userInfo: nil)
                }
                return try self.mapMeal(from: response)
            }
            .eraseToAnyPublisher()
    }

    func fetchRandomMeal() -> AnyPublisher<Meal, Error> {
        requester.randomMeal()
            .tryMap { [weak self] response in
                guard let self = self else {
                    throw NSError(domain: "Self is nil", code: 0, userInfo: nil)
                }
                guard let firstMeal = response.meals?.first else {
                    throw NSError(domain: "MappingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No meal found"])
                }
                return try self.mapMeal(from: firstMeal)
            }
            .eraseToAnyPublisher()
    }

    func fetchRandomSelection() -> AnyPublisher<[Meal], Error> {
        requester.randomSelection()
            .tryMap { response in
                MealsMapper.mapMealsResponse(response)
            }
            .eraseToAnyPublisher()
    }

    func fetchLatestMeals() -> AnyPublisher<[Meal], Error> {
        requester.latestMeals()
            .tryMap { response in
                MealsMapper.mapMealsResponse(response)
            }
            .eraseToAnyPublisher()
    }
}
