//
//  BlurView.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-27.
//

import SwiftUI

class BlurEffectView: UIVisualEffectView {
    
    var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    var style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
        self.style = style
        super.init(effect: nil)
        setupBlur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        frame = superview.bounds
        
        backgroundColor = .clear
        
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: self?.style ?? .regular)
        }
        animator.fractionComplete = 0.2   //насыщенность блюра тут
    }
    
    deinit {
        animator.stopAnimation(true)
    }
    
}


struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> BlurEffectView {
        return BlurEffectView(style: style)
    }

    func updateUIView(_ uiView: BlurEffectView, context: Context) {}
}
