//
//  FavoritesManagerInterface.swift
//  EatHub
//
//  Created by Stepan Chuiko on 29.03.2025.
//

protocol FavoritesManagerInterface {
    func add(mealID: String)
    func remove(mealID: String)
    func isFavorite(mealID: String) -> Bool
    func allFavorites() -> [String]
}
