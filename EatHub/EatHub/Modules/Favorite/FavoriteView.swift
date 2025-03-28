import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()

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
        }
    }
    var favoritesTitle: some View {
        Text("Избранное")
            .font(.largeTitle)
            .bold()
            .padding([.horizontal, .top])
    }
    var favoritesList: some View {
        LazyVStack(spacing: 8) {
            ForEach(viewModel.recipes) { recipe in
//              TODO: Добавить переход
//              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeRow(
                        recipe: recipe,
                        onToggleFavorite: {
                            viewModel.toggleFavorite(for: recipe)
                        }
                    )
//              }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    FavoriteView()
}
