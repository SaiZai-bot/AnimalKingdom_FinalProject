//
//  StorageManager.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/19/25.
//

import Foundation

//declaration of a storage manager to be used for each biome allowing for 1 code to be used for each
class StorageManager {

    // easy global access
    static let shared = StorageManager()
    
    // JSON encoders and decoder
    // easy convertion of Animal arrays to data
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    //takes an array of Animals and their respective keys to know where to store them
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
