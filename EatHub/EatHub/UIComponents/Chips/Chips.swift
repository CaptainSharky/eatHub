//
//  Chips.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUI

struct Chips: View {
    private enum Constants {
        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 6
        static let cornerRadius: CGFloat = 12
    }

    @ObservedObject var viewModel: ChipsViewModel

    public init(viewModel: ChipsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Text(viewModel.text)
            .font(Font.Custom.caption)
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(viewModel.backgroundColor)
            )
            .foregroundColor(viewModel.textColor)
    }
}

// MARK: - Preview

#Preview {
    Chips(viewModel: ChipsViewModel(text: "Соль"))
}
