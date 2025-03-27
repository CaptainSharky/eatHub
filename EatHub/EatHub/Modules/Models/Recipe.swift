import Foundation

// Модель рецепта
struct Recipe: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var imageName: String
    var isFavorite: Bool = true
}
