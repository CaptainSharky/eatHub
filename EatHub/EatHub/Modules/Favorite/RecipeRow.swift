import SwiftUI

struct RecipeRow: View {
    @ObservedObject var recipe: RecipeViewModel
    let onToggleFavorite: () -> Void

    private enum Constants {
        static let rowHeight: CGFloat = 100
        static let imageWidth: CGFloat = 100
        static let heartSize: CGFloat = 22
        static let likeSize: CGFloat = 24
        static let cornerRadius: CGFloat = 12
        static let horizontalPadding: CGFloat = 0
    }

    var body: some View {
<<<<<<< HEAD
        HStack(spacing: 0) {
            if let url = URL(string: recipe.thumbnail ?? "") {
=======
        HStack {
<<<<<<< HEAD
            if let url = URL(string: recipe.imageName) {
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
            if let url = URL(string: recipe.thumbnail ?? "") {
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
<<<<<<< HEAD
                        .frame(width: Constants.imageWidth, height: Constants.rowHeight)
                        .clipped()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: Constants.imageWidth, height: Constants.rowHeight)
                        .skeletonable(true)
                }
=======
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .skeletonable(true)
                }
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                .clipped()
                .cornerRadius(Constants.imageCornerRadius)
            }

            Text(recipe.name)
                .font(.headline)
                .padding(.leading, 8)

            Spacer()

            Button(action: onToggleFavorite) {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(recipe.isFavorite ? .red : .gray)
                    .font(.system(size: Constants.heartSize))
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
            }
            HStack {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: onToggleFavorite) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(recipe.isFavorite ? .red : .gray)
                        .font(.system(size: Constants.heartSize))
                }
            }
            .padding()
            .frame(height: Constants.rowHeight)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.rowHeight)
        .background(Color(.systemBackground))
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
