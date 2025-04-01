//
//  LikeButton.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 31.03.2025.
//

import SwiftUI

// MARK: - View

struct LikeButton: View {
    private enum Constants {
        static let likedImage: String = "heart.fill"
        static let defaultImage: String = "heart"
    }
    @StateObject var viewModel: LikeButtonViewModel

    var body: some View {
        Button(action: {
            viewModel.toggleLike()
        }) {
            ZStack {
                if viewModel.style == .large {
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Image(systemName: viewModel.isLiked ? Constants.likedImage : Constants.defaultImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(viewModel.style.tapPadding)
                    .foregroundColor(viewModel.isLiked ? .red : viewModel.style.untappedColor)
                    .scaleEffect(viewModel.animate ? 1.3 : 1.0)
                    .animation(
                        .easeInOut(duration: viewModel.animationDuration),
                        value: viewModel.animate
                    )
            }
            .frame(width: viewModel.style.size.width, height: viewModel.style.size.height)
        }
    }
}

// MARK: - Previews

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            LikeButton(
                viewModel: LikeButtonViewModel(style: .large)
            )
            LikeButton(
                viewModel: LikeButtonViewModel(style: .small)
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

// MARK: Preview

#Preview {
    LikeButton(viewModel: LikeButtonViewModel(style: .large))
    LikeButton(viewModel: LikeButtonViewModel(style: .small))
}
