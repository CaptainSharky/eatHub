//
//  MainView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 25.03.2025.
//

import SwiftUI

struct MainView: View {

    // MARK: - Properties
    @State var selectedIndex: MainTabEnum = .home

    // MARK: - ViewModel
    @ObservedObject var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                HomeView(viewModel: viewModel.homeViewModel)
                    .tag(MainTabEnum.home)
                SearchView(viewModel: viewModel.searchViewModel)
                    .tag(MainTabEnum.search)
                FavoriteView()
                    .tag(MainTabEnum.favorites)
            }

            VStack(spacing: 0) {
                Spacer()
                MainTabBar(selectedIndex: $selectedIndex)
            }
        }
    }
}

#Preview {
    let dependencies = AppDependencies()
    return MainView(viewModel: dependencies.mainViewModel)
}
