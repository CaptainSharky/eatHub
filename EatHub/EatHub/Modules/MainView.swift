//
//  MainView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 25.03.2025.
//

import SwiftUI

struct MainView: View {

    @State var selectedIndex: MainTabEnum = .home
    var dependencies: AppDependencies
    private var launchScreenState: LaunchScreenStateManager

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.launchScreenState = dependencies.launchScreenStateManager
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                HomeView(viewModel: dependencies.makeHomeViewModel())
                    .tag(MainTabEnum.home)
                SearchView(viewModel: dependencies.makeSearchViewModel())
                    .tag(MainTabEnum.search)
                FavoriteView(viewModel: dependencies.makeFavoriteViewModel())
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
    let launchScreenState = LaunchScreenStateManager()
    return MainView(dependencies: dependencies)
}
