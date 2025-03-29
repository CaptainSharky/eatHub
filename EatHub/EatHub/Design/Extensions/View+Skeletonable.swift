//
//  View+Skeletonable.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 29.03.2025.
//

import SwiftUICore

public extension View {
    func skeletonable(_ isSkeletonable: Bool) -> AnyView {
        if isSkeletonable {
            AnyView(
                redacted(reason: .placeholder)
                    .shimmering(
                        gradient: Gradient(colors: [
                            Color(.black),
                            Color(.black.withAlphaComponent(0.2)),
                            Color(.black),
                        ]),
                        bandSize: 0.5
                    )
                    .foregroundColor(Color.secondary)
            )
        } else {
            AnyView(foregroundColor(.clear))
        }
    }
}
