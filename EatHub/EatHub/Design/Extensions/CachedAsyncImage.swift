//
//  CachedAsyncImage.swift
//  EatHub
//
//  Created by Даниил Дементьев on 28.03.2025.
//
import SwiftUI
import os

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL
    @ViewBuilder let content: (Image) -> Content
    @ViewBuilder let placeholder: () -> Placeholder

    @Environment(\.imageCache) private var cache

    var body: some View {
        if let image = cache[url] {
            content(image)
        } else {
            AsyncImage(
                url: url,
                content: { image in
                    content(image)
                        .task {
                            saveImageIfNeeded(image)
                        }
                },
                placeholder: {
                    placeholder()
                }
            )
        }
    }

    private func saveImageIfNeeded(_ image: Image) {
        guard cache[url] == nil else { return }
        cache[url] = image
    }
}
