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
    let favoriteViewModel: FavoriteViewModel

    init(homeViewModel: HomeViewModel, searchViewModel: SearchViewModel, favoriteViewModel: FavoriteViewModel) {
        self.homeViewModel = homeViewModel
        self.searchViewModel = searchViewModel
        self.favoriteViewModel = favoriteViewModel
    }
}
