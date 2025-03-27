import Foundation

struct Recipe: Identifiable, Equatable {
    let id: Int
    var name: String
    var imageName: String
    var isFavorite: Bool = true
}
