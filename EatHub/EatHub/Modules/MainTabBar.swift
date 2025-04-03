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

    private var color: Color {
        switch colorScheme {
            case .dark:
                return .white
            default:
                return .black
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTabEnum.allCases, id: \.self) { tabType in
                tabBarButton(for: tabType)
            }
        }
        .padding(.vertical, 20)
        .background(
            BlurView(style: .systemChromeMaterialLight)
                .edgesIgnoringSafeArea(.all)
        )
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

extension MainTabBar {
    @ViewBuilder
    private func tabBarButton(for tabType: MainTabEnum) -> some View {
        let isSelected = selectedIndex == tabType
        let foregroundColor: Color = isSelected ? .red : color
        let scaleEffect: CGFloat = isSelected ? 1.4 : 1.0

        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                selectedIndex = tabType
            }
        } label: {
            Image(systemName: tabType.imageName)
                .foregroundColor(foregroundColor)
                .scaleEffect(scaleEffect)
                .frame(maxWidth: .infinity)
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {

    @State static var selectedTab = MainTabEnum.home
    static var previews: some View {
        MainTabBar(selectedIndex: $selectedTab)
    }
}
