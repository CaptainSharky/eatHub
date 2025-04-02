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
                NavigationLink(value: meal) {
                    let viewModel = VerticalItemViewModel(
                        id: meal.id,
                        name: meal.name,
                        thumbnail: meal.thumbnail,
                        category: meal.category,
                        area: meal.area
                    )
                    VerticalItemView(viewModel: viewModel)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            )
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
