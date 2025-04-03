//
//  DetailsView.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUI

struct DetailsView: View {
    private enum Constants {
        static let chipSpacing: CGFloat = 8
        static let backButtonSize: CGFloat = 44
        static let imageCornerRadius: CGFloat = 24
        static let imageHeight: CGFloat = 200
        static let spacing: CGFloat = Spacing.large.rawValue

        enum Icons {
            static let area: String = "globe"
            static let category: String = "square.grid.2x2"
            static let back: String = "arrow.backward"
            static let youtube: String = "play.rectangle.fill"
        }

        enum Title {
            static let ingredients: String = "Ingredients"
            static let instructions: String = "Instructions"
            static let youtube: String = "Watch tutorial"
        }
    }

    @EnvironmentObject var tabBarVisibility: TabBarVisibilityManager
    @StateObject var viewModel: DetailsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    VerticalItemView(viewModel: viewModel.verticalItemViewModel)
                    makeTagsChipsScrollView()
                    ingredientsSection
                    instructionsSection
                }
            }
            .ignoresSafeArea(edges: .top)
            .safeAreaInset(edge: .top) {
                HStack {
                    makeBackButton()
                    Spacer()
                    makeLikeButton()
                }
                .padding(.horizontal, .large)
                .padding(.vertical, .large)
            }
            .background(Color.Custom.backgroundPrimary)
            .onAppear {
                viewModel.fetchMeal()
                withAnimation {
                    tabBarVisibility.isVisible = false
                }
            }
            .onDisappear {
                withAnimation {
                    tabBarVisibility.isVisible = true
                }
            }
        }
        .navigationBarHidden(true)
    }
}

private extension DetailsView {
    @ViewBuilder
    func makeTagsChipsScrollView() -> some View {
        if !viewModel.tagsChips.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Constants.chipSpacing) {
                    ForEach(viewModel.tagsChips, id: \.text) { chip in
                        Chips(viewModel: chip)
                    }
                }
                .padding(.horizontal, .large)
            }
        }
    }

    var ingredientsSection: some View {
        Group {
            if !viewModel.ingredients.isEmpty {
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    Text(Constants.Title.ingredients)
                        .font(Font.Custom.title)
                        .padding(.top)
                    ForEach(viewModel.ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            if let measure = ingredient.measure {
                                Text(measure)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(.horizontal, .large)
            }
        }
    }

    var instructionsSection: some View {
        Group {
            if let instructions = viewModel.instructions {
                VStack {
                    makeInstructionsContent(instructions: instructions)
                    if let url = viewModel.youtubeURL {
                        makeYoutubeLink(url: url)
                    }
                }
                .padding(Constants.spacing)
                .frame(maxWidth: .infinity)
            }
        }
    }

    @ViewBuilder
    func makeBackButton() -> some View {
        Button(action: { dismiss() }) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                Image(systemName: Constants.Icons.back)
                    .font(.title)
                    .padding(.all, .large)
                    .foregroundColor(.white)
            }
            .frame(
                width: Constants.backButtonSize,
                height: Constants.backButtonSize
            )
        }
        .frame(width: Constants.backButtonSize, height: Constants.backButtonSize)
    }

    func makeLikeButton() -> some View {
        LikeButton(
            viewModel: LikeButtonViewModel(
                style: .large,
                isLiked: viewModel.isLiked,
                onLikeChanged: { newValue in
                    viewModel.updateMealInFavorites(isLiked: newValue)
                }
            )
        )
    }

    func makeInstructionsContent(instructions: String) -> some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(Constants.Title.instructions)
                .font(Font.Custom.subtitle)
                .frame(alignment: .leading)
            Text(instructions)
                .font(.body)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
        }
        .padding(.all, .large)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(Constants.spacing)
    }

    @ViewBuilder
    func makeYoutubeLink(url: URL) -> some View {
        Link(destination: url) {
            HStack {
                Image(systemName: Constants.Icons.youtube)
                Text(Constants.Title.youtube)
                    .bold()
            }
            .padding(.all, .large)
            .foregroundColor(.white)
            .background(Color.Custom.accent)
            .cornerRadius(Constants.spacing)
        }
    }
}

// MARK: - Preview

#Preview("Meal Details") {
    let requester = APIRequester()
    let mealsService = MealsService(requester: requester)
    let favoritesManager = FavoritesManager(store: UserDefaults.standard)

    NavigationView {
        DetailsView(
            viewModel: DetailsViewModel(
                id: "1",
                name: "Beetroot Soup",
                category: "Soup",
                area: "Polish",
                tagsChips: [
                    ChipsViewModel(text: "Vegan"),
                    ChipsViewModel(text: "Healthy")
                ],
                instructions: """
                    1. Peel and chop the beetroot.
                    2. Boil in water with a splash of vinegar.
                    3. Add spices and diced potatoes.
                    4. Simmer until soft.
                """,
                ingredients: [
                    Ingredient(name: "Tomato", measure: "3 pcs"),
                    Ingredient(name: "Potato", measure: "2 pcs"),
                    Ingredient(name: "Crocodilo", measure: "1 pcs"),
                    Ingredient(name: "Kadilo", measure: "33 pcs")
                ],
                youtubeURL: URL(string: "example.com"),
                favoritesManager: favoritesManager,
                mealsService: mealsService
            )
        )
    }
}
