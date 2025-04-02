//
//  RandomItemView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-31.
//

import SwiftUI

struct RandomItemView: View {

    private enum Constants {
        static let imageSize: CGFloat = 300
        static let imageCornerRadius: CGFloat = 40
        static let textPlaceholderCornerRadius: CGFloat = 20

        static let nameTextHeight: CGFloat = 25
        static let nameTextSize: CGFloat = 25

        static let VStackSpacing: CGFloat = 16

        static let labelHeight: CGFloat = 20
        static let labelWidth: CGFloat = 70

        static let horizontalPaddingView: CGFloat = 20

        enum Colors {
            static let darkGray = Color(uiColor: .systemGray2)
            static let lightGray = Color(uiColor: .systemGray4)
        }

        enum Icons {
            static let area: String = "globe"
            static let category: String = "square.grid.2x2"
        }
    }

    var item: Meal?
    private var isShimmered: Bool = false

    init(item: Meal? = nil) {
        self.item = item
        self.isShimmered = item == nil
    }

    var body: some View {
        Group {
            if isShimmered {
                shimmeredPlaceholder
            } else if let item {
                mealView(meal: item)
            }
        }
        .frame(width: Constants.imageSize)
    }
}

extension RandomItemView {
    @ViewBuilder
    private var shimmeredPlaceholder: some View {
        VStack(spacing: Constants.VStackSpacing) {
            RectanglePlaceholder(
                width: Constants.imageSize,
                height: Constants.imageSize,
                cornerRadius: Constants.imageCornerRadius,
                color: Constants.Colors.darkGray
            )
            VStack {
                RectanglePlaceholder(
                    width: .infinity,
                    height: Constants.nameTextHeight,
                    cornerRadius: Constants.textPlaceholderCornerRadius,
                    color: Constants.Colors.lightGray
                )
                HStack {
                    RectanglePlaceholder(
                        width: Constants.labelWidth,
                        height: Constants.labelHeight,
                        cornerRadius: Constants.textPlaceholderCornerRadius,
                        color: Constants.Colors.lightGray
                    )
                    RectanglePlaceholder(
                        width: Constants.labelWidth,
                        height: Constants.labelHeight,
                        cornerRadius: Constants.textPlaceholderCornerRadius,
                        color: Constants.Colors.lightGray
                    )
                    Spacer()
                }
            }
            .padding(.horizontal, Constants.horizontalPaddingView)
        }
        .shimmering(bandSize: 1)
    }

    @ViewBuilder
    private func mealView(meal: Meal) -> some View {
        VStack(spacing: Constants.VStackSpacing) {
            ZStack {
                if let url = URL(string: meal.thumbnail ?? "") {
                    AsyncImage(url: url)
                } else {
                    Image("MealTemplate")
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .cornerRadius(Constants.imageCornerRadius)
            .clipped()
            VStack {
                Text(meal.name)
                    .lineLimit(1)
                    .font(.system(size: Constants.nameTextSize, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    if let category = meal.category {
                        Label(category, systemImage: Constants.Icons.category)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let area = meal.area {
                        Label(area, systemImage: Constants.Icons.area)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, Constants.horizontalPaddingView)
        }
    }
}

#Preview {
    RandomItemView()
    RandomItemView(
        item:
            Meal(
                id: "0",
                name: "Eda",
                category: "pupupu",
                instructions: nil,
                thumbnail: nil,
                area: nil,
                tags: nil,
                youtube: nil,
                ingredients: [
                    Ingredient(
                        name: "",
                        measure: nil
                    )
                ]
            )
    )
}
