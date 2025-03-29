//
//  EatHubApp.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import SwiftUI

@main
struct EatHubApp: App {

    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: dependencies.mainViewModel)
        }
    }
}
