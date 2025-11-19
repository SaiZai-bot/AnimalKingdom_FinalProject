//
//  StorageManager.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/19/25.
//

import Foundation

class StorageManager {

    static let shared = StorageManager()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    func saveAnimals(_ animals: [Animals], key: String) {
        if let data = try? encoder.encode(animals) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadAnimals(key: String) -> [Animals] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? decoder.decode([Animals].self, from: data) {
            return decoded
        }
        return []
    }
}
