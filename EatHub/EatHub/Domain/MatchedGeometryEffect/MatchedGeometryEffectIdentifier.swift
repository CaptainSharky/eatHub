//
//  MatchedGeometryEffectIdentifier.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 30.03.2025.
//

struct MatchedGeometryEffectIdentifier: Hashable, CustomStringConvertible {
    let type: MatchedGeometryEffectType
    let id: String

    init(_ type: MatchedGeometryEffectType, for id: String) {
        self.type = type
        self.id = id
    }

    var description: String {
        "\(type.rawValue)-\(id)"
    }
}
