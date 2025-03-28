import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    let title = "Favourites"

    init() {
        loadMockData()
    }

    func toggleFavorite(for recipe: Recipe) {
        guard let index = recipes.firstIndex(of: recipe) else { return }
        recipes[index].isFavorite.toggle()
    }

    private func loadMockData() {
        recipes = [
            Recipe(id: 0, name: "Паста Карбонара", imageName: "caesar"),
            Recipe(id: 1, name: "Пицца Маргарита", imageName: "caesar"),
            Recipe(id: 2, name: "Салат Цезарь", imageName: "caesar"),
            Recipe(id: 3, name: "Паста Карбонара", imageName: "caesar"),
            Recipe(id: 4, name: "Пицца Маргарита", imageName: "caesar"),
            Recipe(id: 5, name: "Салат Цезарь", imageName: "caesar"),
            Recipe(id: 6, name: "Паста Карбонара", imageName: "caesar"),
            Recipe(id: 7, name: "Пицца Маргарита", imageName: "caesar"),
            Recipe(id: 8, name: "Салат Цезарь", imageName: "caesar"),
            Recipe(id: 9, name: "Паста Карбонара", imageName: "caesar"),
            Recipe(id: 10, name: "Пицца Маргарита", imageName: "caesar"),
            Recipe(id: 11, name: "Салат Цезарь", imageName: "caesar")
        ]
    }
}
