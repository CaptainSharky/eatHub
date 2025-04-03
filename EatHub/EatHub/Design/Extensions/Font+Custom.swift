//
//  Font+Custom.swift
//  EatHub
//
//  Created by Stepan Chuiko on 03.04.2025.
//
import SwiftUI

extension Font {
    enum Custom {
        /// Font: Bold | line height: 32
        static let headline = Font.custom("MalintonTrialVersion-Bold", size: 32)

        /// Font: Bold | line height: 24
        static let title = Font.custom("MalintonTrialVersion-Bold", size: 24)

        /// Font: Semibold | line height: 20
        static let subtitle = Font.custom("MalintonTrialVersion-Semibold", size: 20)

        /// Font: Regular | line height: 16
        static let regular = Font.custom("MalintonTrialVersion-Regular", size: 16)

        /// Font: Regular | line height: 14
        static let caption = Font.custom("MalintonTrialVersion-Regular", size: 14)
    }
}
