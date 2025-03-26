//
//  ChipsViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUICore

public final class ChipsViewModel: ObservableObject {

    let text: String
    let backgroundColor: Color
    let textColor: Color

    public init(
        text: String,
        backgroundColor: Color = Color.green.opacity(0.2),
        textColor: Color = .secondary
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
