//
//  APIRequester.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Foundation
import Combine

final class APIRequester {
    // MARK: Private properties

    let session: URLSession = {
        let configuration = URLSessionConfiguration.default

        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        configuration.networkServiceType = .responsiveData
        configuration.allowsCellularAccess = true

        return URLSession(configuration: configuration)
    }()

    // MARK: Private methods

    private func request<T: Decodable>(target: APIProvider, type: T.Type) -> AnyPublisher<T, Error> {
        guard let request = target.urlRequest else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return data
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
