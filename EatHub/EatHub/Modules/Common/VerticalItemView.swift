//
//  VerticalItemView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct VerticalItemView: View {
    let meal: Meal

    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: meal.thumbnail ?? "") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(20)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.name).font(.headline)
                if let category = meal.category {
                    Text(category).font(.subheadline).foregroundColor(.gray)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
