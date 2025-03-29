//
//  Debouncer.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import Foundation

public typealias Action = () -> Void

public final class Debouncer {

    // MARK: - Private properties

    private let timeInterval: TimeInterval
    private var timer: Timer?

    private var handler: Action?

    // MARK: - Init

    public init(
        timeInterval: TimeInterval,
        handler: Action?
    ) {
        self.timeInterval = timeInterval
        self.handler = handler
    }

    // MARK: - Public functions

    public func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: false,
            block: { [weak self] timer in
                guard let self else { return }

                timeIntervalDidFinish(for: timer)
            }
        )
    }

    public func stop() {
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
