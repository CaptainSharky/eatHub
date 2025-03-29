import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {
    @Published var likedRecipes: [RecipeViewModel] = []
    var recipesIdentifiers: [String] = []

    let title = "Favourites"

    private let favoritesManager: FavoritesManagerInterface
    private let mealsService: MealsServiceInterface
    private var cancellables = Set<AnyCancellable>()

    init(favoritesManager: FavoritesManagerInterface, mealsService: MealsServiceInterface) {
        self.favoritesManager = favoritesManager
        self.mealsService = mealsService

        // убрать
        favoritesManager.populateInitialFavorites(with: ["52943", "52869", "52883", "52823"])
    }

    func toggleFavorite(for recipe: RecipeViewModel) {
        if recipe.isFavorite {
            favoritesManager.remove(recipeID: recipe.id)
        } else {
            favoritesManager.add(recipeID: recipe.id)
        }

        recipe.isFavorite.toggle()
    }

    func refreshFavorites() {
        cancellables.removeAll()

        let currentFavoriteIDs = Set(favoritesManager.allFavorites())

        likedRecipes.removeAll { !currentFavoriteIDs.contains($0.id) }

        let existingIDs = Set(likedRecipes.map { $0.id })
        let newIDs = currentFavoriteIDs.subtracting(existingIDs)

        loadNewRecipes(ids: Array(newIDs))
    }

    private func loadNewRecipes(ids: [String]) {
        cancellables.removeAll()

        for id in ids {
            mealsService.fetchMeal(id: id)
                .receive(on: DispatchQueue.main)
                .sink { _ in } receiveValue: { [weak self] meal in
                    if let recipe = meal?.mapToRecipe() {
                        self?.likedRecipes.append(recipe)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
