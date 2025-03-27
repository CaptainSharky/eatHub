//
//  MainViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedIndex: MainTabEnum = .home
    
    func selectIndex(_ tabType: MainTabEnum) {
        selectedIndex = tabType
    }
}
