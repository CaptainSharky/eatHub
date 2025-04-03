//
//  View+Padding.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-04-03.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ignoreTabBar() -> some View {
        self.padding(.bottom, 80)
    }
}
