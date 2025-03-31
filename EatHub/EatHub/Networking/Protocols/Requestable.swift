//
//  Requestable.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Combine

protocol Requestable: AnyObject {
    /// Поиск блюда по названию.
    ///
    /// - Parameter name: Название блюда для поиска.
    func searchMeal(name: String) -> AnyPublisher<MealsResponseModel, Error>

    /// Получить информацию о блюде по его идентификатору.
    ///
    /// - Parameter id: Идентификатор блюда.
    func lookupMeal(id: String) -> AnyPublisher<MealsResponseModel, Error>

    /// Получить случайное блюдо.
    func randomMeal() -> AnyPublisher<MealsResponseModel, Error>

    /// Получить подборку из 10 случайных блюд.
    func randomSelection() -> AnyPublisher<MealsResponseModel, Error>

    /// Получить последние добавленные блюда.
    func latestMeals() -> AnyPublisher<MealsResponseModel, Error>
}
