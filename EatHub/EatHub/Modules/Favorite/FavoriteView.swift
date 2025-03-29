import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    favoritesTitle
                    favoritesList
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onAppear {
                viewModel.refreshFavorites()
            }
        }
    }
}

private extension FavoriteView {
    var favoritesTitle: some View {
        Text(viewModel.title)
            .font(.largeTitle)
            .bold()
            .padding([.horizontal, .top])
    }

    var favoritesList: some View {
        LazyVStack(spacing: 8) {
            ForEach(viewModel.likedRecipes) { recipe in
                // TODO: Добавить переход
                // NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeRow(
                    recipe: recipe,
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: recipe)
                    }
                )
                // }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
