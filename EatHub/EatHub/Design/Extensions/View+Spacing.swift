//
//  View+Padding.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 03.04.2025.
//

import SwiftUICore

extension View {
    @inlinable func padding(_ edges: Edge.Set = .all, _ spacing: Spacing) -> some View {
        self.padding(edges, spacing.rawValue)
    }
}
