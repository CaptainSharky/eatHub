import Foundation

final class FavoriteViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    let title = "Favourites"
    private let favoritesManager: FavoritesManagerInterface

    init(favoritesManager: FavoritesManagerInterface = FavoritesManager()) {
        self.favoritesManager = favoritesManager
        loadMockData()
    }

    func toggleFavorite(for recipe: Recipe) {
        guard let index = recipes.firstIndex(of: recipe) else { return }

        if recipe.isFavorite {
            favoritesManager.remove(recipeID: recipe.id)
        } else {
            favoritesManager.add(recipeID: recipe.id)
        }

        recipes[index].isFavorite.toggle()
    }

    private func loadMockData() {
        let favoriteIDs = Set(favoritesManager.allFavorites())

        recipes = [
            Recipe(id: 0, name: "Паста Карбонара 1", imageName: "caesar"),
            Recipe(id: 1, name: "Пицца Маргарита 2", imageName: "caesar"),
            Recipe(id: 2, name: "Салат Цезарь 3", imageName: "caesar"),
            Recipe(id: 3, name: "Паста Карбонара 4", imageName: "caesar"),
            Recipe(id: 4, name: "Пицца Маргарита 5", imageName: "caesar"),
            Recipe(id: 5, name: "Салат Цезарь 6", imageName: "caesar"),
            Recipe(id: 6, name: "Паста Карбонара 7", imageName: "caesar"),
            Recipe(id: 7, name: "Пицца Маргарита 8", imageName: "caesar"),
            Recipe(id: 8, name: "Салат Цезарь 9", imageName: "caesar"),
            Recipe(id: 9, name: "Паста Карбонара 10", imageName: "caesar"),
            Recipe(id: 10, name: "Пицца Маргарита 11", imageName: "caesar"),
            Recipe(id: 11, name: "Салат Цезарь 12", imageName: "caesar")
        ].map { recipe in
            var modified = recipe
            modified.isFavorite = favoriteIDs.contains(recipe.id)
            return modified
        }
    }
}
