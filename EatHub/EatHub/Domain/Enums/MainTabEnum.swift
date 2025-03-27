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
            //TODO: - SF Symbols или кастомные добавить когда найдем
            case .home:
                "frying.pan"
            case .search:
                "magnifyingglass"
            case .favorites:
                "star.square.on.square.fill"
            case .random:
                "shuffle"
        }
    }
}
