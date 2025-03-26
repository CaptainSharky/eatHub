import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []

    init() {
        loadMockData()
    }

    func toggleFavorite(for recipe: Recipe) {
        guard let index = recipes.firstIndex(of: recipe) else { return }
        recipes[index].isFavorite.toggle()
    }

    private func loadMockData() {
        recipes = [
            Recipe(name: "Паста Карбонара", imageName: "karbonara"),
            Recipe(name: "Пицца Маргарита", imageName: "margarita"),
            Recipe(name: "Салат Цезарь", imageName: "caesar"),
            Recipe(name: "Паста Карбонара", imageName: "karbonara"),
            Recipe(name: "Пицца Маргарита", imageName: "margarita"),
            Recipe(name: "Салат Цезарь", imageName: "caesar"),
            Recipe(name: "Паста Карбонара", imageName: "karbonara"),
            Recipe(name: "Пицца Маргарита", imageName: "margarita"),
            Recipe(name: "Салат Цезарь", imageName: "caesar"),
            Recipe(name: "Паста Карбонара", imageName: "karbonara"),
            Recipe(name: "Пицца Маргарита", imageName: "margarita"),
            Recipe(name: "Салат Цезарь", imageName: "caesar")
        ]
    }
}
