//
//  EatHubApp.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import SwiftUI

@main
struct EatHubApp: App {

    @StateObject var launchScreenStateManager = LaunchScreenStateManager()

    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView(dependencies: dependencies, launchScreenState: launchScreenStateManager)
                if launchScreenStateManager.state != .finished {
                    LaunchScreenView(launchScreenStateManager: launchScreenStateManager)
                }
            }
        }
    }
}
