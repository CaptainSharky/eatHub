//
//  HorizontalListSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

struct HorizontalListSection: View {
    let meals: [Meal]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(meals, id: \.id) { meal in
                    NavigationLink(value: meal) {
                        HorizontalItemView(meal: meal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
}
