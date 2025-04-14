//
//  CircleShadow.swift
//  SwiftUI Animation+Shaders
//
//  Created by anastasiia talmazan on 2025-04-02.
//  Created by Кизим Илья on 29.03.2024.
//

import SwiftUI

struct CircleShadow: View {
    @Binding var isLoading: Bool

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    @State private var angleTwo: Double = 0
    @State private var value: CGFloat = 50
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var rotationAngle: Double = 0
    @State private var rotationSpeed: Double = 0.1
    @State private var isRotating: Bool = false
    @State private var timerAnimator: Timer?
    private var date = Date()

    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.Custom.backgroundPrimary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    TimelineView(.animation()) { timeline in
                        let time = date.timeIntervalSince1970 - timeline.date.timeIntervalSince1970

                        CustomCircle(
                            time: time,
                            speed: 3,
                            smoothing: 40,
                            strength: 15,
                            lineWidth: 30,
                            width: 400,
                            trimFrom: 0.0,
                            trimTo: 1
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: isLoading ? [
                                    Color.Custom.accent.opacity(0.2),
                                    Color.Custom.accent,
                                    Color.Custom.accent
                                ]
                                : [
                                    Color.Custom.accent.opacity(0.4),
                                    Color.gray.opacity(0.5),
                                    Color.Custom.accent.opacity(0.6)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .blur(radius: 10)
                        .rotationEffect(.degrees(rotationAngle))
                        .onAppear {
                            startRotation()
                        }

                        CustomCircle(
                            time: time,
                            speed: -2,
                            smoothing: -40,
                            strength: -30,
                            lineWidth: 30,
                            width: 400,
                            trimFrom: 0.0,
                            trimTo: 1
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: isLoading
                                ? [.clear, Color.Custom.accent, Color.Custom.accent]
                                : [.clear, Color.Custom.backgroundAccent.opacity(0.3)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .blur(radius: 10)
                        .rotationEffect(.degrees(angleTwo))
                        .animation(
                            .linear(duration: 20).repeatForever(autoreverses: false),
                            value: angleTwo
                        )
                        .onAppear {
                            angleTwo = -360
                        }
                    }
                )
                .ignoresSafeArea()
        }
        .onChange(of: isLoading) { _, newValue in
            withAnimation {
                rotationSpeed = newValue ? 0.05 : 0.1
            }
        }
    }

    func startRotation() {
        timerAnimator = Timer.scheduledTimer(withTimeInterval: rotationSpeed, repeats: true) { _ in
            rotationAngle += 1
        }
    }

    func stopRotation() {
        timerAnimator?.invalidate()
        timerAnimator = nil
    }
}

struct CustomCircle: View {
    let time: TimeInterval
    let speed: Float
    let smoothing: Float
    let strength: Float
    let lineWidth: CGFloat
    let width: CGFloat
    let trimFrom: CGFloat
    let trimTo: CGFloat

    var body: some View {
        Circle()
            .trim(from: trimFrom, to: trimTo)
            .stroke(style: StrokeStyle(lineWidth: lineWidth))
            .frame(width: width, height: width)
            .distortionEffect(
                ShaderLibrary.waveCircle(
                    .float(Float(time)),
                    .float(speed),
                    .float(smoothing),
                    .float(strength)
                ),
                maxSampleOffset: CGSize(width: 200, height: 200)
            )
    }
}

#Preview {
    CircleShadow(isLoading: .constant(false))
        .blur(radius: 20)
        .allowsHitTesting(false)
}
