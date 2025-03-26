//
//  HorizontalScrollSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

struct HorizontalScrollSection: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.horizontalMeals.indices, id: \.self) { index in
                    HorizontalItemView(index: index)
                }
            }
            .padding(.horizontal)
        }
    }
}
