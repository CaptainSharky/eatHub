//
//  HorizontalItemView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct HorizontalItemView: View {
    let meal: Meal

    var body: some View {
        ZStack(alignment: .bottom) {
            if let url = URL(string: meal.thumbnail ?? "") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .skeletonable(true)
                }
                .frame(width: 100, height: 180)
                .clipped()
                .cornerRadius(5)
            }

            ZStack(alignment: .bottom) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 60)
                .frame(maxWidth: .infinity)

                Text(meal.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 8)
            }
            .frame(width: 100, height: 60)
        }
        .frame(width: 100, height: 180)
        .cornerRadius(11)
        .shadow(color: Color.black.opacity(0.5), radius: 4)
    }
}
