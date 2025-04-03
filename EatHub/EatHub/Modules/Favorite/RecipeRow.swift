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
        HStack(spacing: 0) {
            if let url = URL(string: recipe.thumbnail ?? "") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.imageWidth, height: Constants.rowHeight)
                        .clipped()
                } placeholder: {
                    Color.Custom.backgroundSecondary
                        .frame(width: Constants.imageWidth, height: Constants.rowHeight)
                        .skeletonable(true)
                }
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
        .background(Color.Custom.backgroundAccent)
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
