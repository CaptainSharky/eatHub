//
//  EnvironmentKey.swift
//  EatHub
//
//  Created by Даниил Дементьев on 29.03.2025.
//
import SwiftUI

private struct ImageCacheKey: EnvironmentKey {
    static let defaultValue = ImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
