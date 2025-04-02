//
//  LikeButtonViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 01.04.2025.
//

import SwiftUI

final class LikeButtonViewModel: ObservableObject {
    private enum Constants {
        static let animationDuration: Double = 0.2
    }

    enum Style {
        case small
        case large
    }

    @Published var isLiked: Bool
    @Published var animate: Bool = false
    let style: LikeButtonViewModel.Style
    var onLikeChanged: ((Bool) -> Void)?

    var animationDuration: Double {
        Constants.animationDuration
    }

    init(
        style: Style,
        isLiked: Bool = false,
        onLikeChanged: ((Bool) -> Void)? = nil
    ) {
        self.style = style
        self.isLiked = isLiked
        self.onLikeChanged = onLikeChanged
    }

    func toggleLike() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isLiked.toggle()
            animate = true
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + Constants.animationDuration
        ) { [weak self] in
            guard let self else { return }
            animate = false
            onLikeChanged?(isLiked)
        }
    }
}

// MARK: - LikeButtonViewModel.Style

extension LikeButtonViewModel.Style {
    var size: CGSize {
        switch self {
            case .small:
                return CGSize(width: 24, height: 24)
            case .large:
                return CGSize(width: 44, height: 44)
        }
    }

    var tapPadding: CGFloat {
        switch self {
            case .small:
                return .zero
            case .large:
                return 10
        }
    }

    var untappedColor: Color {
        switch self {
            case .small:
                return Color.black.opacity(0.3)
            case .large:
                return Color.white
        }
    }
}
