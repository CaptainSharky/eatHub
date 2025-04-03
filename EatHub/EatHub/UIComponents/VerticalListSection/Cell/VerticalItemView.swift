//
//  VerticalItemView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct VerticalItemView: View {
    private enum Constants {
        static let hStackSpacing: CGFloat = 12
        static let imageHeight: CGFloat = 200
        static let imageCornerRadius: CGFloat = 24
        static let vStackSpacing: CGFloat = 4
        static let cellCornerRadius: CGFloat = 24
        static let defaultPadding: CGFloat = 16
        static let spacing: CGFloat = 16

        enum Icons {
            static let area: String = "globe"
            static let category: String = "square.grid.2x2"
        }
    }

    @ObservedObject var viewModel: VerticalItemViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            makeMealImage()
            infoSection
        }
        .padding(.bottom, Constants.spacing)
        .background(Color.Custom.backgroundAccent)
        .clipped()
        .cornerRadius(Constants.cellCornerRadius, corners: .allCorners)
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            if let name = viewModel.name {
                Text(name)
                    .font(Font.Custom.title)
            }
            HStack {
                makeCategoryIfNeeded()
                makeAreaIfNeeded()
            }
        }
        .padding(.horizontal, Constants.spacing)
    }

    @ViewBuilder
    private func makeMealImage() -> some View {
        Group {
            if let url = URL(string: viewModel.thumbnail ?? "") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.Custom.backgroundSecondary
                        .skeletonable(true)
                }
            } else {
                Image("MealTemplate")
            }
        }
        .scaledToFill()
        .frame(height: Constants.imageHeight)
        .clipped()
        .cornerRadius(Constants.imageCornerRadius, corners: [.bottomLeft, .bottomRight])
    }

    @ViewBuilder
    private func makeCategoryIfNeeded() -> some View {
        if let category = viewModel.category {
            Label(category, systemImage: Constants.Icons.category)
                .font(Font.Custom.caption)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func makeAreaIfNeeded() -> some View {
        if let area = viewModel.area {
            Label(area, systemImage: Constants.Icons.area)
                .font(Font.Custom.caption)
                .foregroundColor(.secondary)
        }
    }
}
