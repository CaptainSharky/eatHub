//
//  FavoritesManager.swift
//  EatHub
//
//  Created by Valeriy Chuiko on 29.03.2025.
//
import Foundation

final class FavoritesManager {
    // MARK: - Private properties

    private let userDefaults: UserDefaults
    private let favoritesKey = "favorite_recipes_ids"

    // MARK: - Lifecycle

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension FavoritesManager: FavoritesManagerInterface {
    // MARK: - FavoritesManagerInterface
    
    func add(recipeID: Int) {
        var current = allFavorites()
        guard !current.contains(recipeID) else { return }
        current.append(recipeID)
        save(current)
    }

    func remove(recipeID: Int) {
        var current = allFavorites()
        current.removeAll() { $0 == recipeID }
        save(current)
    }

    func isFavorite(recipeID: Int) -> Bool {
        allFavorites().contains(recipeID)
    }

    func allFavorites() -> [Int] {
        userDefaults.array(forKey: favoritesKey) as? [Int] ?? []
    }

    func populateInitialFavorites(with ids: [Int]) {
        var current = Set(allFavorites())
        ids.forEach { current.insert($0) }
        save(Array(current))
    }

    // MARK: - Private functions

    private func save(_ ids: [Int]) {
        userDefaults.set(ids, forKey: favoritesKey)
    }
}
