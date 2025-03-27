//
//  ContentView.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            navigationBasedOnTab(index: viewModel.selectedIndex)
            
            VStack(spacing: 0) {
                Spacer()
                MainTabBar(selectedIndex: $viewModel.selectedIndex)
            }
        }
    }
}

extension MainView {
    func navigationBasedOnTab(index: MainTabEnum) -> some View {
        Group {
            switch index {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .favorites:
                    EmptyView()
                case .random:
                    EmptyView()
            }
        }
    }
}

#Preview {
    MainView()
}
