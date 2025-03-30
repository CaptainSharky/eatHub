//
//  VerticalItemViewModel.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 30.03.2025.
//

import SwiftUI

final class VerticalItemViewModel: ObservableObject {
    @Published var id: String
    @Published var name: String?
    @Published var thumbnail: String?
    @Published var category: String?
    @Published var area: String?

    init(
        id: String,
        name: String?,
        thumbnail: String?,
        category: String?,
        area: String?
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.category = category
        self.area = area
    }
}
