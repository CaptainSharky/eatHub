import Foundation

class RecipeViewModel: ObservableObject, Identifiable {
    let id: String
    let meal: Meal
    @Published var name: String
    @Published var imageName: String
    @Published var isFavorite: Bool = true

    init(id: String, meal: Meal) {
        self.id = id
        self.name = meal.name
        self.imageName = meal.thumbnail ?? ""
        self.meal = meal
    }
}
