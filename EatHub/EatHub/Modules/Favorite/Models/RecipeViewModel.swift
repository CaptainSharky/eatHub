import Foundation

class RecipeViewModel: ObservableObject, Identifiable {
    let id: String
    @Published var name: String
    @Published var thumbnail: String?
    @Published var isFavorite: Bool

    init(
        id: String,
        name: String,
        thumbnail: String?,
        isFavorite: Bool = true
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.isFavorite = isFavorite
    }
}
