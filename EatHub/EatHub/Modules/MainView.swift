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

    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

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
                FavoriteView(viewModel: viewModel.favoriteViewModel)
                    .tag(MainTabEnum.favorites)
            }

            VStack(spacing: 0) {
                Spacer()
                MainTabBar(selectedIndex: $selectedIndex)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            launchScreenState.dismiss()
        }
    }
}

#Preview {
    let dependencies = AppDependencies()
    return MainView(viewModel: dependencies.mainViewModel)
        .environmentObject(LaunchScreenStateManager())
}
