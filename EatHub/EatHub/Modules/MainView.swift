//
//  MainView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 25.03.2025.
//

import SwiftUI

struct MainView: View {

    @StateObject var tabBarVisibility = TabBarVisibilityManager()
    @State var selectedIndex: MainTabEnum = .home

    var dependencies: AppDependencies
    private var launchScreenState: LaunchScreenStateManager

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.launchScreenState = dependencies.launchScreenStateManager
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedIndex) {
                HomeView(viewModel: dependencies.makeHomeViewModel())
                    .tag(MainTabEnum.home)
                    .environmentObject(tabBarVisibility)
                SearchView(viewModel: dependencies.makeSearchViewModel())
                    .tag(MainTabEnum.search)
                    .environmentObject(tabBarVisibility)
                FavoriteView(viewModel: dependencies.makeFavoriteViewModel())
                    .tag(MainTabEnum.favorites)
                    .environmentObject(tabBarVisibility)
                RandomView(viewModel: dependencies.makeRandomViewModel())
                    .tag(MainTabEnum.random)
                    .environmentObject(tabBarVisibility)
            }

            MainTabBar(selectedIndex: $selectedIndex)
                .opacity(tabBarVisibility.isVisible ? 1 : 0)
        }
        .ignoresSafeArea(.keyboard)
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
