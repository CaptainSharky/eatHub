//
//  RectanglePlaceholder.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-04-02.
//

import SwiftUI

struct RectanglePlaceholder: View {

    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(maxWidth: width)
            .frame(height: height)

    }
}

#Preview {
    RectanglePlaceholder(
        width: 10,
        height: 10,
        cornerRadius: 10,
        color: .black
    )
}
