import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    @State private var selectedItem: RecipeViewModel?
    @State private var showDetail: Bool = false
    @Namespace private var animationNamespace

    private enum Constants {
        static let animationDuration: TimeInterval = 0.5
        static let detailZIndex: Double = 1
        static let detailTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom)
        )
        static let heartSizeWhenEmpty: CGFloat = 64
    }

    var body: some View {
        NavigationStack {
            contentView
                .background(Color(.systemGroupedBackground))
                .onAppear {
                    viewModel.refreshFavorites()
                }
        }
        .navigationDestination(for: RecipeViewModel.self) { recipeViewModel in
            let input = DetailsViewModuleInput(
                id: recipeViewModel.id,
                name: recipeViewModel.name,
                thumbnail: recipeViewModel.thumbnail
            )
            let detailsViewModel = viewModel.detailsViewModelBuilder(input)
            DetailsView(viewModel: detailsViewModel)
        }
        .navigationTitle(viewModel.title)
    }
}

private extension FavoriteView {
    var contentView: some View {
        Group {
            if viewModel.likedRecipes.isEmpty {
                nonScrollableEmptyState
            } else {
                scrollableFavoritesList
            }
        }
    }

    var nonScrollableEmptyState: some View {
        VStack(alignment: .leading, spacing: 0) {
            favoritesTitle
            Spacer()
            HStack {
                Spacer()
                emptyPlaceholder
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(.systemGroupedBackground))
    }

    var scrollableFavoritesList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                favoritesTitle
                favoritesList
            }
            .padding(.horizontal)
        }
    }

    var favoritesTitle: some View {
        Text(viewModel.title)
            .font(.largeTitle)
            .bold()
            .padding([.horizontal, .top])
    }

    var favoritesList: some View {
        LazyVStack(spacing: 8) {
            ForEach(viewModel.likedRecipes) { recipeViewModel in
                NavigationLink(value: recipeViewModel) {
                    RecipeRow(
                        recipe: recipeViewModel,
                        onToggleFavorite: {
                            viewModel.toggleFavorite(for: recipeViewModel)
                        }
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top, 8)
    }

    var emptyPlaceholder: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .frame(
                    width: Constants.heartSizeWhenEmpty,
                    height: Constants.heartSizeWhenEmpty
                )
                .foregroundColor(.gray)

            Text("Лайкни свой первый рецепт")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
