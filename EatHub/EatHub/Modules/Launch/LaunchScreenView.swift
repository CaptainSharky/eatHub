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

    private enum Constants {
        enum Layout {
            static let imageSize: CGFloat = 200
            static let logoWidth: CGFloat = 275
            static let imageCornerRadius: CGFloat = 40
            static let imageBlurRadius: CGFloat = 10
            static let logoVerticalOffset: CGFloat = 50
        }

        enum Opacity {
            static let imageStroke: Double = 0.3
            static let imageBackground: Double = 0.1
            static let imageFaded: Double = 0.5
            static let imageFull: Double = 1.0
        }

        enum Animation {
            static let imageScaleSmall: CGFloat = 1.9
            static let imageScaleLarge: CGFloat = 2.5
            static let fadeOutDuration: TimeInterval = 0.6
            static let scaleDuration: TimeInterval = 1.5
            static let timerInterval: TimeInterval = 1.5
        }
    }

    private let animationTimer = Timer
        .publish(every: Constants.Animation.timerInterval, on: .current, in: .common)
        .autoconnect()

    init(dependencies: AppDependencies) {
        self._launchScreenStateManager = ObservedObject(wrappedValue:
                                                            dependencies.launchScreenStateManager)
    }

    var body: some View {
        ZStack {
            backgroundColor
            content
        }
        .onReceive(animationTimer) { _ in
            updateAnimation()
        }
        .opacity(startFadeoutAnimation ? 0 : 1)
    }

    private var content: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            ZStack {
                Image("LaunchIcon")
                    .resizable()
                    .frame(
                        width: Constants.Layout.imageSize,
                        height: Constants.Layout.imageSize
                    )
                    .clipShape(
                        RoundedRectangle(
                        cornerRadius: Constants.Layout.imageCornerRadius,
                        style: .continuous
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Layout.imageCornerRadius)
                            .stroke(
                                Color.Custom.backgroundPrimary.opacity(
                                    Constants.Opacity.imageStroke
                                ),
                                lineWidth: 2
                            )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: Constants.Layout.imageCornerRadius)
                            .fill(Color.white.opacity(Constants.Opacity.imageBackground))
                            .blur(radius: Constants.Layout.imageBlurRadius)
                    )
                    .scaleEffect(
                        x: firstAnimation ? Constants.Animation.imageScaleLarge :
                            Constants.Animation.imageScaleSmall,
                        y: firstAnimation ? Constants.Animation.imageScaleLarge :
                            Constants.Animation.imageScaleSmall,
                        anchor: .bottom
                    )
                    .opacity(
                        firstAnimation ? Constants.Opacity.imageFaded :
                            Constants.Opacity.imageFull
                    )
                    .position(x: screenWidth / 2, y: screenHeight - Constants.Layout.imageSize / 2)
                    .animation(
                        .easeOut(duration:
                                    Constants.Animation.scaleDuration),
                        value: firstAnimation
                    )

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Layout.logoWidth)
                    .position(
                        x: screenWidth / 2,
                        y: screenHeight / 2 - Constants.Layout.logoVerticalOffset
                    )
            }
        }
        .ignoresSafeArea()
    }

    private var backgroundColor: some View {
        Color.Custom.backgroundPrimary
            .ignoresSafeArea()
    }

    private func updateAnimation() {
        switch launchScreenStateManager.state {
        case .firstStep:
            firstAnimation = true
        case .secondStep:
            if !secondAnimation {
                secondAnimation = true
                withAnimation(.easeIn(duration: Constants.Animation.fadeOutDuration)) {
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            break
        }
    }
}
