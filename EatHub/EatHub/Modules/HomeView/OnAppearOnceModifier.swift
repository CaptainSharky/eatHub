//
//  OnAppearOnceModifier.swift
//  EatHub
//
//  Created by Даниил Дементьев on 27.03.2025.
//

import SwiftUI

private class AppearOnceTracker: ObservableObject {
    @Published var hasAppeared = false
}

struct OnFirstAppearModifier: ViewModifier {
    @StateObject private var tracker = AppearOnceTracker()
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                if !tracker.hasAppeared {
                    tracker.hasAppeared = true
                    action()
                }
            }
    }
}

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        self.modifier(OnFirstAppearModifier(action: action))
    }
}
