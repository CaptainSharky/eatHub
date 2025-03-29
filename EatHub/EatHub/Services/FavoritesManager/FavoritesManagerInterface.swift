//
//  FavoritesManagerInterface.swift
//  EatHub
//
//  Created by Stepan Chuiko on 29.03.2025.
//

protocol FavoritesManagerInterface {
    func add(recipeID: String)
    func remove(recipeID: String)
    func isFavorite(recipeID: String) -> Bool
    func allFavorites() -> [String]
    func populateInitialFavorites(with ids: [String])
}
