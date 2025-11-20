//
//  StorageManager.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/19/25.
//

import Foundation

// Declaration of a storage manager to be used for each biome allowing for 1 code to be used for each
// Utilization of UserDefaults for data persistence of Animal array
class StorageManager {

    // easy global access reference to the instance StorageManager
    static let shared = StorageManager()
    
    // JSON encoders and decoder
    // Easy convertion of Animal arrays to data, and convert data into Animal arrays
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    
    // Initializer to enfore the singleton pattern
    private init() {}

    // Takes an array of Animals and their respective keys to know where to store them
    func saveAnimals(_ animals: [Animals], key: String) {
        
        //converts the array to data
        if let data = try? encoder.encode(animals) {
            
            // writes that data to UserDefaults under a provided key
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    //retrieves data for the given key from UserDefaults
    func loadAnimals(key: String) -> [Animals] {
        if let data = UserDefaults.standard.data(forKey: key),
           
            //attempt to decode the data back into Animals
           let decoded = try? decoder.decode([Animals].self, from: data) {
            return decoded
        }
        return []
    }
}
