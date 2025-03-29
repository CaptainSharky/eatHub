import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Избранное")
                        .font(.largeTitle)
                        .bold()
                        .padding([.horizontal, .top])

                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.recipes) { recipe in
//                            TODO: Добавить переход
//                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRow(
                                    recipe: recipe,
                                    onToggleFavorite: {
                                        viewModel.toggleFavorite(for: recipe)
                                    }
                                )
//                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    let viewModel = FavoriteViewModel()
    FavoriteView(viewModel: viewModel)
}
