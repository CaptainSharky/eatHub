import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {
    @Published var likedRecipes: [RecipeViewModel] = []
    var recipesIdentifiers: [String] = []
<<<<<<< HEAD
<<<<<<< HEAD
    var detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel
=======
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
    var detailsViewModelBuilder: (DetailsViewModuleInput) -> DetailsViewModel
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))

    let title = "Favourites"

    private let favoritesManager: FavoritesManagerInterface
    private let mealsService: MealsServiceInterface
    private var cancellables = Set<AnyCancellable>()

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
    init(
        favoritesManager: FavoritesManagerInterface,
        mealsService: MealsServiceInterface,
        detailsViewModelBuilder: @escaping ((DetailsViewModuleInput) -> DetailsViewModel)
    ) {
<<<<<<< HEAD
        self.favoritesManager = favoritesManager
        self.mealsService = mealsService
        self.detailsViewModelBuilder = detailsViewModelBuilder
=======
    init(favoritesManager: FavoritesManagerInterface, mealsService: MealsServiceInterface) {
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
        self.favoritesManager = favoritesManager
        self.mealsService = mealsService
        self.detailsViewModelBuilder = detailsViewModelBuilder

        // убрать
        favoritesManager.populateInitialFavorites(with: ["52943", "52869", "52883", "52823"])
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
    }

    func toggleFavorite(for recipe: RecipeViewModel) {
        if recipe.isFavorite {
<<<<<<< HEAD
            favoritesManager.remove(mealID: recipe.id)
        } else {
            favoritesManager.add(mealID: recipe.id)
=======
            favoritesManager.remove(recipeID: recipe.id)
        } else {
            favoritesManager.add(recipeID: recipe.id)
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] meal in
                        guard let self else { return }
                        guard let meal else { return }

                        let recipeRowViewModel = RecipeViewModel(
                            id: meal.id,
                            name: meal.name,
                            thumbnail: meal.thumbnail
                        )
                        likedRecipes.append(recipeRowViewModel)
<<<<<<< HEAD
                    }
                )
=======
                .sink { _ in } receiveValue: { [weak self] meal in
                    if let recipe = meal?.mapToRecipe() {
                        self?.likedRecipes.append(recipe)
                    }
                }
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
                    }
                )
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                .store(in: &cancellables)
        }
    }
}
