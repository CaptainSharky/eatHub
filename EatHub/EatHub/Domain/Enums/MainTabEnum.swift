//
//  MainTabEnum.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import Foundation

enum MainTabEnum: Int, CaseIterable {
    case home
    case search
    case favorites
    case random

    var imageName: String {
        switch self {
            case .home:
                "frying.pan"
            case .search:
                "magnifyingglass"
            case .favorites:
                "star"
            case .random:
                "shuffle"
        }
    }

    var animationType: ColorButton.AnimationType {
        switch self {
            case .home: return .bell
            case .search: return .calendar
            case .favorites: return .plus
            case .random: return .gear
        }
    }
}
