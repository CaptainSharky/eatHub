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
            //TODO: - SF Symbols добавить когда найдем
            case .home:
                return "frying.pan"
            case .search:
                return "magnifyingglass"
            case .favorites:
                return "star.square.on.square.fill"
            case .random:
                return "shuffle"
        }
    }
}
