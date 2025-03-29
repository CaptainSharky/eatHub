//
//  VerticalListSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct VerticalListSection: View {
    let meals: [Meal]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(meals, id: \.id) { meal in
                VerticalItemView(meal: meal)
            }
        }
    }
}
