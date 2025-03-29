//
//  EatHubApp.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import SwiftUI

@main
struct EatHubApp: App {

    @StateObject var launchScreenState = LaunchScreenStateManager()

    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView(viewModel: dependencies.mainViewModel)

                if launchScreenState.state != .finished {
                    LaunchScreenView(launchScreenState: launchScreenState)
                }
            }
        }
    }
}
