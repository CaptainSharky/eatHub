import Foundation

class RecipeViewModel: ObservableObject, Identifiable {
    let id: String
    @Published var name: String
    @Published var imageName: String
    @Published var isFavorite: Bool = true

    init(id: String, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
}
