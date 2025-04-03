//
//  ColorButton.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-04-03.
//

import SwiftUI

public struct ColorButton: View {

    public enum AnimationType {
        case bell
        case plus
        case calendar
        case gear
    }

    public var image: Image
    public var isSelected: Bool
    public var animationType: AnimationType

    @State private var t: CGFloat = 0
    @State private var tForBg: CGFloat = 0

    public var body: some View {
        ZStack {
            if isSelected || tForBg > 0 {
                Circle()
                    .fill(Color.accentColor.opacity(0.3))
                    .scaleEffect(tForBg)
                    .frame(width: 40, height: 40)
            }
            switch animationType {
                case .bell:
                    ColorButtonOutlineBell(image: image, t: t)
                case .plus:
                    ColorButtonOutlinePlus(image: image, t: t)
                case .calendar:
                    ColorButtonOutlineCalendar(image: image, t: t)
                case .gear:
                    ColorButtonOutlineGear(image: image, t: t)
            }
        }
        .padding(8)
        .onAppear {
            if isSelected {
                tForBg = 1
            }
        }
        .onChange(of: isSelected) { _, newValue in
            if newValue {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 10).delay(0.15)) {
                    t = 1
                }
                withAnimation(.easeIn(duration: 0.3)) {
                    tForBg = 1
                }
            } else {
                t = 0
                withAnimation(.easeIn(duration: 0.3)) {
                    tForBg = 0
                }
            }
        }
    }
}

struct ColorButtonOutlineBell: View, Animatable {

    var image: Image
    var t: CGFloat

    nonisolated var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    var angle: CGFloat {
        if t < 0.5 {
            return 2*t * 20
        }
        return 2*(1 - t) * 20
    }

    var body: some View {
        image
            .rotationEffect(Angle(degrees: angle), anchor: UnitPoint(x: 0.5, y: 0))
            .font(.system(size: 20))
    }
}

struct ColorButtonOutlinePlus: View {

    var image: Image
    var t: CGFloat

    var body: some View {
        image
            .rotationEffect(Angle(degrees: t * 90))
            .font(.system(size: 20))
    }
}

struct ColorButtonOutlineCalendar: View, Animatable {

    var image: Image
    var t: CGFloat

    nonisolated var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    var body: some View {
        ZStack {
            image
                .offset(x: calendarOffset(maxValue: 5))
                .font(.system(size: 20))
            Circle()
                .frame(width: 3)
                .offset(x: 3, y: 4)
                .offset(x: calendarOffset(maxValue: 8))
        }
    }

    private func calendarOffset(maxValue: CGFloat) -> CGFloat {
        let shift = maxValue * (t < 0.5 ? 2 * t : 2 * (1 - t))
        return shift
    }
}

struct ColorButtonOutlineGear: View {

    var image: Image
    var t: CGFloat

    var body: some View {
        image
            .rotationEffect(Angle(degrees: t * 50))
            .font(.system(size: 20))
    }
}
