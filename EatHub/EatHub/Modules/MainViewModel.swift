//
//  MainViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

final class MainViewModel: ObservableObject {
    let homeViewModel: HomeViewModel
    let searchViewModel: SearchViewModel

    init(homeViewModel: HomeViewModel, searchViewModel: SearchViewModel) {
        self.homeViewModel = homeViewModel
        self.searchViewModel = searchViewModel
    }
}
