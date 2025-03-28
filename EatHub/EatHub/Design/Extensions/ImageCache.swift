//
//  ImageCache.swift
//  EatHub
//
//  Created by Даниил Дементьев on 28.03.2025.
//

import SwiftUI

final class ImageCache {
    private var cache: [URL: Image] = [:]

    subscript(key: URL) -> Image? {
        get { cache[key] }
        set { cache[key] = newValue }
    }
}
