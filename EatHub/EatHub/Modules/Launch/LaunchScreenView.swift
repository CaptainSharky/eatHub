//
//  LaunchScreenView.swift
//  EatHub
//
//  Created by Даниил Дементьев on 29.03.2025.
//

import SwiftUI

struct LaunchScreenView: View {
    @ObservedObject private var launchScreenStateManager: LaunchScreenStateManager

    @State private var firstAnimation = false
    @State private var secondAnimation = false
    @State private var startFadeoutAnimation = false

    init(launchScreenStateManager: LaunchScreenStateManager) {
        _launchScreenStateManager = ObservedObject(wrappedValue: launchScreenStateManager)
    }

    var body: some View {
        ZStack {
            backgroundColor
            image
        }.onReceive(animationTimer) { _ in
            updateAnimation()
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }

    @ViewBuilder
    private var image: some View {
        Image(systemName: "fork.knife.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .foregroundStyle(.white)
            .rotationEffect(firstAnimation ? .degrees(0) : .degrees(360))
            .scaleEffect(secondAnimation ? 0.1 : 1.0)
            .offset(y: secondAnimation ? 500 : 0)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
            .animation(.easeInOut(duration: 1.3), value: firstAnimation)
            .animation(.easeIn(duration: 0.6), value: secondAnimation)
    }

    @ViewBuilder
    private var backgroundColor: some View {
        LinearGradient(
            colors: [Color.orange, Color.red],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private let animationTimer = Timer
        .publish(every: 1.5, on: .current, in: .common)
        .autoconnect()

    private func updateAnimation() {
        switch launchScreenStateManager.state {
        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            break
        }
    }

}
