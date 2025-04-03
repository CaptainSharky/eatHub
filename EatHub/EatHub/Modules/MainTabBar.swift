//
//  MainTabBar.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-26.
//

import SwiftUI
import UIKit

struct MainTabBar: View {

    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedIndex: MainTabEnum

    var body: some View {
        VStack(spacing: 0) {
            EdgeTriangles()
                .fill(Color.tabBarBackground)
                .frame(height: 30)
            HStack(spacing: 0) {
                ForEach(Array(MainTabEnum.allCases.enumerated()), id: \.1) { index, tabType in
                    let isSelected = selectedIndex == tabType
                    tabBarButton(for: tabType, index: index, isSelected: isSelected)
                }
            }
            .background(
                Color.tabBarBackground
            )
        }
    }
}

struct EdgeTriangles: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height
        let triangleSize: CGFloat = 50
        let arcHeight: CGFloat = 1

        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: height - triangleSize))
        path.addQuadCurve(
            to: CGPoint(x: triangleSize, y: height),
            control: CGPoint(x: triangleSize * 0.2, y: height - arcHeight)
        )
        path.closeSubpath()

        path.move(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: height - triangleSize))
        path.addQuadCurve(
            to: CGPoint(x: width - triangleSize, y: height),
            control: CGPoint(x: width - triangleSize * 0.2, y: height - arcHeight)
        )
        path.closeSubpath()

        return path
    }
}

extension MainTabBar {
    @ViewBuilder
    private func tabBarButton(for tabType: MainTabEnum, index: Int, isSelected: Bool) -> some View {
        Button {
            withAnimation {
                selectedIndex = tabType
            }
        } label: {
            ColorButton(
                image: Image(systemName: tabType.imageName),
                isSelected: isSelected,
                animationType: tabType.animationType
            )
        }
        .frame(maxWidth: .infinity)
    }
}

struct MainTabBar_Previews: PreviewProvider {

    @State static var selectedTab = MainTabEnum.home
    static var previews: some View {
        MainTabBar(selectedIndex: $selectedTab)
    }
}
