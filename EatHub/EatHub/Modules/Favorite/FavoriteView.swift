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
    }

    var body: some View {
        NavigationView {
            ZStack {
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

                if let selectedItem, showDetail {
                    openDetailsView(for: selectedItem)
                }
            }
            .navigationBarHidden(true)
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
        .padding(.horizontal)
        .padding(.top, 8)
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
