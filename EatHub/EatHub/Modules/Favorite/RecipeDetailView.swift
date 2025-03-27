import SwiftUI

// Временный экран деталей рецепта (удалим)
struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Text(recipe.name)
                .font(.largeTitle)
                .padding()

            Spacer()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
