//
//  FavoritesManager.swift
//  EatHub
//
//  Created by Stepan Chuiko on 29.03.2025.
//
import Foundation

final class FavoritesManager {
    private let store: KeyValueStore
    private let favoritesKey = "favorite_recipes_ids"

    init(store: KeyValueStore = UserDefaults.standard) {
        self.store = store
    }
}

extension FavoritesManager: FavoritesManagerInterface {
    func add(recipeID: String) {
        var current = allFavorites()
        guard !current.contains(recipeID) else { return }
        current.append(recipeID)
        save(current)
    }

    func remove(recipeID: String) {
        var current = allFavorites()
        current.removeAll { $0 == recipeID }
        save(current)
    }

    func isFavorite(recipeID: String) -> Bool {
        allFavorites().contains(recipeID)
    }

    func allFavorites() -> [String] {
        store.array(forKey: favoritesKey)
    }

    func populateInitialFavorites(with ids: [String]) {
        var current = Set(allFavorites())
        ids.forEach { current.insert($0) }
        save(Array(current))
    }

    private func save(_ ids: [String]) {
        store.set(ids, forKey: favoritesKey)
    }
}
