//
//  ContentView.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import SwiftUI

struct MainView: View {

    @State var selectedIndex: MainTabEnum = .home

    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                let requester = APIRequester()
                let service = MealsService(requester: requester)
                let viewModel = HomeViewModel(mealsService: service)
                HomeView(viewModel: viewModel)
                    .tag(MainTabEnum.home)
                SearchView()
                    .tag(MainTabEnum.search)
            }

            VStack(spacing: 0) {
                Spacer()
                MainTabBar(selectedIndex: $selectedIndex)
            }
        }
    }
}

#Preview {
    MainView()
}
