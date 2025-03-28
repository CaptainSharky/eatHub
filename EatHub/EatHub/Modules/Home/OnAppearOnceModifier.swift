//
//  OnAppearOnceModifier.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        self.modifier(OnFirstAppearModifier(action: action))
    }
}

fileprivate struct OnFirstAppearModifier: ViewModifier {
    @State private var hasAppeared = false
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                action()
            }
    }
}
