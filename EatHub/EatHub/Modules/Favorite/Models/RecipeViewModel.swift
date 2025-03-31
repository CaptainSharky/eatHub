import Foundation

class RecipeViewModel: ObservableObject, Identifiable {
    let id: String
    @Published var name: String
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
    @Published var imageName: String
    @Published var isFavorite: Bool = true
=======
    @Published var thumbnail: String?
    @Published var isFavorite: Bool
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))

    init(
        id: String,
        name: String,
        thumbnail: String?,
        isFavorite: Bool = true
    ) {
        self.id = id
        self.name = name
<<<<<<< HEAD
        self.imageName = imageName
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
        self.thumbnail = thumbnail
        self.isFavorite = isFavorite
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
    }
}
