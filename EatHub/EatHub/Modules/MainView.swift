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

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
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
    }
}

#Preview {
    let dependencies = AppDependencies()
    return MainView(dependencies: dependencies)
}
