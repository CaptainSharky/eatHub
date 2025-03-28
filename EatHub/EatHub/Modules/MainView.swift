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
                HomeView()
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
