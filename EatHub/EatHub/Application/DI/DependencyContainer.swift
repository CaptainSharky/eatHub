//
//  DependencyContainer.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//


final class DependencyContainer {
    static let shared = DependencyContainer()

    private lazy var apiRequester: Requestable = APIRequester()

    // MARK: Services

    var mealsService: MealsServiceInterface {
        MealsService(requester: apiRequester)
    }
}
