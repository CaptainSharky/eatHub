//
//  View+Tappable.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 29.03.2025.
//

import SwiftUI

extension View {
    func makeTappable(_ action: @escaping () -> Void) -> some View {
        self
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded {
                    action()
                }
            )
    }
}
