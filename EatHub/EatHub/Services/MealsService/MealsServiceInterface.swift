//
//  MealsServiceInterface.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Combine

protocol MealsServiceInterface: AnyObject {

    func searchMeal(name: String) -> AnyPublisher<[Meal], Error>

    func fetchMeal(id: String) -> AnyPublisher<Meal, Error>

    func fetchRandomMeal() -> AnyPublisher<Meal, Error>

    func fetchRandomSelection() -> AnyPublisher<[Meal], Error>

    func fetchLatestMeals() -> AnyPublisher<[Meal], Error>
}
