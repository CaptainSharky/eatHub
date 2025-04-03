//
//  ChipsViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUICore

final class ChipsViewModel: ObservableObject {

    let text: String
    let backgroundColor: Color
    let textColor: Color

    public init(
        text: String,
        backgroundColor: Color = Color.Custom.accent,
        textColor: Color = .white
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
