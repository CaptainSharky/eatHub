//
//  CenteredVStaskText.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-31.
//

import SwiftUI

struct CenteredVStaskText: View {

    var text: String

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    CenteredVStaskText(text: "Some text")
}
