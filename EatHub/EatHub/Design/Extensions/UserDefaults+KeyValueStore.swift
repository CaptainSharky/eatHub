//
//  UserDefaults+KeyValueStore.swift
//  EatHub
//
//  Created by Stepan Chuiko on 30.03.2025.
//
import Foundation

extension UserDefaults: KeyValueStore {
    func array<T>(forKey defaultName: String) -> [T] {
        (self.array(forKey: defaultName) as? [T]) ?? []
    }
}
