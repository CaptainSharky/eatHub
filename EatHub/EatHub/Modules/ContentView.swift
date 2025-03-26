import SwiftUI

// MARK: - Model

struct Recipe: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var imageName: String
    var isFavorite: Bool = true
}

// MARK: - Favorite View

struct FavoriteView: View {
    @State private var recipes: [Recipe] = [
        Recipe(name: "Паста Карбонара", imageName: "karbonara"),
        Recipe(name: "Пицца Маргарита", imageName: "margarita"),
        Recipe(name: "Салат Цезарь", imageName: "caesar"),
        Recipe(name: "Паста Карбонара", imageName: "karbonara"),
        Recipe(name: "Пицца Маргарита", imageName: "margarita"),
        Recipe(name: "Салат Цезарь", imageName: "caesar"),
        Recipe(name: "Паста Карбонара", imageName: "karbonara"),
        Recipe(name: "Пицца Маргарита", imageName: "margarita"),
        Recipe(name: "Салат Цезарь", imageName: "caesar"),
        Recipe(name: "Паста Карбонара", imageName: "karbonara"),
        Recipe(name: "Пицца Маргарита", imageName: "margarita"),
        Recipe(name: "Салат Цезарь", imageName: "caesar")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Header
                    Text("Избранное")
                        .font(.largeTitle)
                        .bold()
                        .padding([.horizontal, .top])
                    
                    // Recipe list
                    LazyVStack(spacing: 8) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRow(
                                    recipe: recipe,
                                    onToggleFavorite: {
                                        toggleFavorite(for: recipe)
                                    }
                                )
                            }
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
    
    private func toggleFavorite(for recipe: Recipe) {
        if let index = recipes.firstIndex(of: recipe) {
            recipes[index].isFavorite.toggle()
        }
    }
}

// MARK: - Recipe Row View

struct RecipeRow: View {
    let recipe: Recipe
    let onToggleFavorite: () -> Void
    
    var body: some View {
        HStack {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(8)
            
            Text(recipe.name)
                .font(.headline)
                .padding(.leading, 8)
            
            Spacer()
            
            Button(action: onToggleFavorite) {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(recipe.isFavorite ? .red : .gray)
                    .font(.system(size: 22))
            }
        }
        .padding()
        .foregroundColor(.primary)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Recipe Detail View

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

// MARK: - Preview

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
