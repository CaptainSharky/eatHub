import SwiftUI

struct RecipeRow: View {
    @ObservedObject var recipe: RecipeViewModel
    let onToggleFavorite: () -> Void

    private enum Constants {
        static let imageWidth: CGFloat = 60
        static let imageHeight: CGFloat = 60
        static let imageCornerRadius: CGFloat = 8
        static let heartSize: CGFloat = 22
        static let HStackCornerRadius: CGFloat = 12
        static let likeSize: CGFloat = 24
    }

    var body: some View {
        HStack {
            if let url = URL(string: recipe.thumbnail ?? "") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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

            LikeButton(
                viewModel: LikeButtonViewModel(
                    style: .small,
                    isLiked: recipe.isFavorite,
                    onLikeChanged: { _ in
                        onToggleFavorite()
                    }
                )
            )
            .frame(
                width: Constants.likeSize,
                height: Constants.likeSize
            )
        }
        .padding()
        .foregroundColor(.primary)
        .background(Color(.systemBackground))
        .cornerRadius(Constants.HStackCornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
