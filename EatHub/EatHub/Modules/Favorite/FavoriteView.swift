import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    @State private var selectedMeal: Meal?
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

                if let meal = selectedMeal, showDetail {
                    openDetailsView(for: meal)
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
            ForEach(viewModel.likedRecipes) { recipe in
                RecipeRow(
                    recipe: recipe,
                    onToggleFavorite: {
                        viewModel.toggleFavorite(for: recipe)
                    }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                        selectedMeal = recipe.meal
                        showDetail = true
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }

    @ViewBuilder
    func openDetailsView(for meal: Meal) -> some View {
        let viewModel = viewModel.detailsViewModelBuilder(
            DetailsViewModuleInput(
                id: meal.id,
                name: meal.name,
                thumbnail: meal.thumbnail
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
                    selectedMeal = nil
                }
            },
            namespace: animationNamespace
        )
        .zIndex(Constants.detailZIndex)
        .transition(Constants.detailTransition)
    }
}
