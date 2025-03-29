//
//  VerticalListSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

struct VerticalListSection: View {
    let meals: [Meal]
    let namespace: Namespace.ID
    var onSelect: (Meal) -> Void

    var body: some View {
        VStack(spacing: 12) {
            ForEach(meals, id: \.id) { meal in
                let viewModel = VerticalItemViewModel(
                    id: meal.id,
                    name: meal.name,
                    thumbnail: meal.thumbnail,
                    category: meal.category,
                    area: meal.area
                )
                VerticalItemView(viewModel: viewModel, namespace: namespace)
                    .id(viewModel.id)
                    .matchedGeometryEffect(
                        id: MatchedGeometryEffectIdentifier(.info, for: meal.id),
                        in: namespace
                    )
                    .makeTappable {
                        onSelect(meal)
                    }
            }
        }
    }
}
