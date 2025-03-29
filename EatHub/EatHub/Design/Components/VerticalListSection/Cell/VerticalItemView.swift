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
    let namespace: Namespace.ID

    init(viewModel: VerticalItemViewModel, namespace: Namespace.ID) {
        self.viewModel = viewModel
        self.namespace = namespace
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            makeMealImage()
                .matchedGeometryEffect(
                    id: MatchedGeometryEffectIdentifier(.image, for: viewModel.id),
                    in: namespace
                )
            infoSection
        }
        .padding(.bottom, Constants.spacing)
        .background(Color.gray.opacity(0.1))
        .clipped()
        .cornerRadius(Constants.cellCornerRadius, corners: .allCorners)
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            if let name = viewModel.name {
                Text(name)
                    .font(.title)
                    .bold()
                    .matchedGeometryEffect(
                        id: MatchedGeometryEffectIdentifier(.title, for: viewModel.id),
                        in: namespace
                    )
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
                    Color.gray.opacity(0.3)
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
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func makeAreaIfNeeded() -> some View {
        if let area = viewModel.area {
            Label(area, systemImage: Constants.Icons.area)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .matchedGeometryEffect(
                    id: MatchedGeometryEffectIdentifier(.area, for: viewModel.id),
                    in: namespace
                )
        }
    }
}
