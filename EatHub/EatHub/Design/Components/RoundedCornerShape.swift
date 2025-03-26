//
//  RoundedCornerShape.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 26.03.2025.
//

import SwiftUICore
import UIKit

struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
