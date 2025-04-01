//
//  KeyValueStore.swift
//  EatHub
//
//  Created by Stepan Chuiko on 30.03.2025.
//

protocol KeyValueStore {
    func set(_ value: Any?, forKey defaultName: String)
    func array<T>(forKey defaultName: String) -> [T]
}
