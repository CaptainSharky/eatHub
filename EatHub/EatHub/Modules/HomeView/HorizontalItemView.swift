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
        ZStack {
            AsyncImage(url: URL(string: meal.thumbnail ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(35)

            VStack {
                Spacer()
                Text(meal.name)
                    .font(.caption)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(8)
                    .padding(.bottom, 6)
                    .padding(.horizontal, 6)
            }
            .frame(width: 150, height: 150)
        }
    }
}


