//
//  FavoritesManagerInterface.swift
//  EatHub
//
//  Created by Valeriy Chuiko on 29.03.2025.
//

protocol FavoritesManagerInterface {
    func add(recipeID: Int)
    func remove(recipeID: Int)
    func isFavorite(recipeID: Int) -> Bool
    func allFavorites() -> [Int]
}
