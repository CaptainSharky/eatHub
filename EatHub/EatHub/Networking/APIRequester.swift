//
//  APIRequester.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class APIRequester {
    // MARK:  Private properties

    private let provider = MoyaProvider<APIProvider>()

    // MARK:  Private methods

    private func request<T: Decodable>(target: APIProvider, type: T.Type) -> AnyPublisher<T, Error> {
        provider.requestPublisher(target)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Requestable

extension APIRequester: Requestable {
    func searchMeal(name: String) -> AnyPublisher<MealsResponseModel, Error> {
        request(
            target: .searchMeal(name: name),
            type: MealsResponseModel.self
        )
    }

    func lookupMeal(id: String) -> AnyPublisher<MealItemResponseModel, Error> {
        request(
            target: .mealDetails(id: id),
            type: MealItemResponseModel.self
        )
    }

    func randomMeal() -> AnyPublisher<MealsResponseModel, Error> {
        request(
            target: .randomMeal,
            type: MealsResponseModel.self
        )
    }

    func randomSelection() -> AnyPublisher<MealsResponseModel, Error> {
        request(
            target: .randomSelection,
            type: MealsResponseModel.self
        )
    }

    func latestMeals() -> AnyPublisher<MealsResponseModel, Error> {
        request(
            target: .latestMeals,
            type: MealsResponseModel.self
        )
    }
}
