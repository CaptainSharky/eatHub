//
//  HorizontalItemView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct HorizontalItemView: View {
    private enum Constants {
        static let itemWidth: CGFloat = 100
        static let itemHeight: CGFloat = 180
        static let gradientHeight: CGFloat = 60
        static let cornerRadius: CGFloat = 16
        static let shadowRadius: CGFloat = 4
        static let shadowX: CGFloat = 0
        static let shadowY: CGFloat = 2
        static let horizontalPadding: CGFloat = 4
        static let textBottomPadding: CGFloat = 8
    }

    let meal: Meal

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if let url = URL(string: meal.thumbnail ?? "") {
                    CachedAsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.Custom.backgroundSecondary
                            .skeletonable(true)
                    }
                } else {
                    Color.Custom.backgroundSecondary
                }
            }
            .frame(width: Constants.itemWidth, height: Constants.itemHeight)
            .clipped()

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: Constants.gradientHeight)
            .frame(maxWidth: .infinity)
            .overlay(
                Text(meal.name)
                    .font(Font.Custom.caption)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .padding(.horizontal, Constants.horizontalPadding)
                    .padding(.bottom, Constants.textBottomPadding),
                alignment: .bottom
            )
        }
        .frame(width: Constants.itemWidth, height: Constants.itemHeight)
        .cornerRadius(Constants.cornerRadius)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: Constants.shadowRadius,
            x: Constants.shadowX,
            y: Constants.shadowY
        )
        .contentShape(Rectangle())
    }
}
