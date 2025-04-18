//
//  ShakeGesture.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-04-02.
//  https://github.com/globulus/swiftui-shake-gesture?tab=readme-ov-file
//

import SwiftUI

extension Notification.Name {
    static let shakeEnded = Notification.Name("ShakeEnded")
}

public extension UIWindow {
     override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .shakeEnded, object: nil)
        }
        super.motionEnded(motion, with: event)
     }
}

struct ShakeDetector: ViewModifier {
    let onShake: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear() // this has to be here because of a SwiftUI bug
            .onReceive(NotificationCenter.default.publisher(for: .shakeEnded)) { _ in
                onShake()
            }
    }
}

public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(ShakeDetector(onShake: action))
    }
}
