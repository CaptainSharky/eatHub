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

    init(store: KeyValueStore?) {
        self.store = store ?? UserDefaults.standard
    }
}

extension FavoritesManager: FavoritesManagerInterface {
    func add(mealID: String) {
        var current = allFavorites()
        guard !current.contains(mealID) else { return }
        current.append(mealID)
        save(current)
    }

    func remove(mealID: String) {
        var current = allFavorites()
        current.removeAll { $0 == mealID }
        save(current)
    }

    func isFavorite(mealID: String) -> Bool {
        allFavorites().contains(mealID)
    }

    func allFavorites() -> [String] {
        store.array(forKey: favoritesKey)
    }

    private func save(_ ids: [String]) {
        store.set(ids, forKey: favoritesKey)
    }
}
