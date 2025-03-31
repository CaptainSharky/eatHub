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
<<<<<<< HEAD
        static let heartSizeWhenEmpty: CGFloat = 64
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
    }

    var body: some View {
        NavigationView {
            ZStack {
<<<<<<< HEAD
                contentView
                    .background(Color(.systemGroupedBackground))
                    .onAppear {
                        viewModel.refreshFavorites()
                    }
=======
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        favoritesTitle
                        favoritesList
                    }
                }
                .background(Color(.systemGroupedBackground))
                .onAppear {
                    viewModel.refreshFavorites()
                }
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))

                if let selectedItem, showDetail {
                    openDetailsView(for: selectedItem)
                }
            }
            .navigationBarHidden(true)
        }
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
<<<<<<< HEAD
<<<<<<< HEAD
            ForEach(viewModel.likedRecipes) { recipeViewModel in
=======
            ForEach(viewModel.likedRecipes) { recipe in
                // TODO: Добавить переход
                // NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
            ForEach(viewModel.likedRecipes) { recipeViewModel in
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                RecipeRow(
                    recipe: recipeViewModel,
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: recipeViewModel)
                    }
                )
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                        selectedItem = recipeViewModel
                        showDetail = true
                    }
                }
<<<<<<< HEAD
=======
                // }
                .buttonStyle(PlainButtonStyle())
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
            }
        }
        .padding(.top, 8)
    }
<<<<<<< HEAD
<<<<<<< HEAD

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
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))

    @ViewBuilder
    func openDetailsView(for recipeViewModel: RecipeViewModel) -> some View {
        let viewModel = viewModel.detailsViewModelBuilder(
            DetailsViewModuleInput(
                id: recipeViewModel.id,
                name: recipeViewModel.name,
                thumbnail: recipeViewModel.thumbnail
            )
        )
        DetailsView(
            viewModel: viewModel,
            onClose: {
                withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                    showDetail = false
                    viewModel.isCloseButtonHidden = true
<<<<<<< HEAD
                    self.viewModel.refreshFavorites()
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) {
                    selectedItem = nil
                }
            },
            namespace: animationNamespace
        )
        .zIndex(Constants.detailZIndex)
        .transition(Constants.detailTransition)
    }
<<<<<<< HEAD
=======
>>>>>>> 55ecef7 (#41: добавлен FavoritesManager (#49))
=======
>>>>>>> 0f20ce9 (#40: переход на Деталку из Избранного (#68))
}
