//
//  HorizontalListSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

struct HorizontalListSection: View {
    let meals: [Meal]
    var onSelect: (Meal) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(meals, id: \.id) { meal in
                    HorizontalItemView(meal: meal)
                        .makeTappable {
                            onSelect(meal)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
