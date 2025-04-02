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
        NavigationView {
            ZStack {
                contentView
                    .background(Color(.systemGroupedBackground))
                    .onAppear {
                        viewModel.refreshFavorites()
                    }

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
            ForEach(viewModel.likedRecipes) { recipeViewModel in
                RecipeRow(
                    recipe: recipeViewModel,
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: recipeViewModel)
                    }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                        selectedItem = recipeViewModel
                        showDetail = true
                    }
                }
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
                    self.viewModel.refreshFavorites()
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
}
