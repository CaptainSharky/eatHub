//
//  Debouncer.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

typealias Action = () -> Void

final class Debouncer {

    // MARK: - Private properties

    let timeInterval: TimeInterval
    var timer: Timer?

   var handler: Action?

    // MARK: - Init

    init(
        timeInterval: TimeInterval,
        handler: Action?
    ) {
        self.timeInterval = timeInterval
        self.handler = handler
    }

    // MARK: - Public functions

    func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: false,
            block: { [weak self] timer in
                self?.timeIntervalDidFinish(for: timer)
            }
        )
    }

    func stop() {
        timer?.invalidate()
    }

    // MARK: - Private functions

    @objc
    private func timeIntervalDidFinish(for timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
    }

}
