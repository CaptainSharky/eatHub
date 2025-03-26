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
        static let closeIconSize: CGFloat = 32
        static let horizontalPadding: CGFloat = 16
        static let imageCornerRadius: CGFloat = 24
        static let imageHeight: CGFloat = 250
        static let spacing: CGFloat = 16
        static let areaIcon = "globe"
        static let categoryIcon = "square.grid.2x2"
        static let closeIcon = "xmark.circle.fill"
        static let ingredientsTitle = "Ingredients"
        static let instructionsTitle = "Instructions"
        static let youtubeIcon = "play.rectangle.fill"
        static let youtubeTitle = "Watch tutorial"
    }

    @ObservedObject var viewModel: DetailsViewModel

    @Environment(\.dismiss) private var dismiss

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    makeMealImage()
                    infoSection
                    makeTagsChipsScrollView()
                    ingredientsSection
                    instructionsSection
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .if(viewModel.image != nil) {
                $0.ignoresSafeArea(edges: .top)
            }

            closeButton
                .padding(.trailing, Constants.spacing)
        }
    }

    // MARK: - Subviews

    private var closeButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: Constants.closeIcon)
                .resizable()
                .frame(
                    width: Constants.closeIconSize,
                    height: Constants.closeIconSize
                )
                .foregroundColor(.secondary)
                .background(Color.white.clipShape(Circle()))
        }
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(viewModel.title)
                .font(.title)
                .bold()

            HStack {
                makeCategoryIfNeeded()
                makeAreaIfNeeded()
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
    }

    @ViewBuilder
    private func makeMealImage() -> some View {
        if let image = viewModel.image {
            image
                .resizable()
                .scaledToFill()
                .frame(height: Constants.imageHeight)
                .clipped()
                .cornerRadius(
                    Constants.imageCornerRadius,
                    corners: [.bottomLeft, .bottomRight]
                )
        }
    }

    @ViewBuilder
    private func makeTagsChipsScrollView() -> some View {
        if !viewModel.tagsChips.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Constants.chipSpacing) {
                    ForEach(viewModel.tagsChips, id: \.text) { chip in
                        Chips(viewModel: chip)
                    }
                }
                .padding(.horizontal, Constants.horizontalPadding)
            }
        }
    }

    private var ingredientsSection: some View {
        Group {
            if !viewModel.ingredients.isEmpty {
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    Text(Constants.ingredientsTitle)
                        .font(.headline)
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
                .padding(.horizontal, Constants.horizontalPadding)
            }
        }
    }

    private var instructionsSection: some View {
        Group {
            if let instructions = viewModel.instructions {
                VStack {
                    VStack(alignment: .leading, spacing: Constants.spacing) {
                        Text(Constants.instructionsTitle)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(instructions)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if let url = viewModel.youtubeURL {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: Constants.youtubeIcon)
                                    Text(Constants.youtubeTitle)
                                        .bold()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(Constants.spacing)
                                .foregroundColor(.primary)
                                .background(Color.white)
                                .cornerRadius(Constants.spacing)
                            }
                        }
                    }
                    .padding(Constants.spacing)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(Constants.spacing)
                }
                .padding(Constants.spacing)
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Reusable Helpers

    @ViewBuilder
    private func makeCategoryIfNeeded() -> some View {
        if let category = viewModel.category {
            Label(category, systemImage: Constants.categoryIcon)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func makeAreaIfNeeded() -> some View {
        if let area = viewModel.area {
            Label(area, systemImage: Constants.areaIcon)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview

#Preview("Meal Details") {
    NavigationView {
        DetailsView(
            viewModel: DetailsViewModel(
                title: "Beetroot Soup",
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
                youtubeURL: URL(string: "example.com")
            )
        )
    }
}
