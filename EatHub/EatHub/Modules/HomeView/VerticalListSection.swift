//
//  VerticalListSection.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//
import SwiftUI

struct VerticalListSection: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.verticalMeals.indices, id: \.self) { index in
                VerticalItemView(index: index)
            }
        }
    }
}
