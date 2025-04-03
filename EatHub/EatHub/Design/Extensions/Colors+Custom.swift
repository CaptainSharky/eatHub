//
//  Colors+Custom.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 03.04.2025.
//

import SwiftUI

// MARK: - Расширение для динамических цветов
extension Color {
    enum Custom {
        /// Акцентный цвет
        static let accent = Color("accent")

        /// Основной фон
        static let backgroundPrimary = Color("backgroundPrimary")

        /// Вторичный фон
        static let backgroundSecondary = Color("backgroundSecondary")

        /// Акцентный фон
        static let backgroundAccent = Color("backgroundAccent")

        /// Акцентный фон
        static let textPrimary = Color("textPrimary")
    }
}
