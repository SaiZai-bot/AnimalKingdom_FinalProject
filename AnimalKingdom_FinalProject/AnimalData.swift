//
//  AnimalData.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/17/25.
//

import UIKit

//Let Animal Data act as a singleton
class AnimalData {
    
    //lets AnimalData be one globally shared instance for every view controller to use
    static let shared = AnimalData()
    
    //preventing others from creating more instances and forces the use of AnimalData.shared
    private init(){
        loadData()
    }
    
    //declares keys for each biome to know where to save the animals in UserDefaults
    private let forestKey = "forest_animals"
    private let oceanKey = "ocean_animals"
    private let desertKey = "desert_animals"
    private let arcticKey = "arctic_animals"
    
    //Create dummy animals for each biome
    private let defaultForest = [
        Animals(type: "Forest1", name: "Bear", desc: "Add later", imageFile: "bear"),
        Animals(type: "Forest2", name: "Fox", desc: "Add later", imageFile: "fox"),
        Animals(type: "Forest3", name: "Squirrel", desc: "Add later", imageFile: "squirrel")
    ]

    private let defaultOcean = [
        Animals(type: "Ocean1", name: "Octopus", desc: "Add later", imageFile: "octopus"),
        Animals(type: "Ocean2", name: "Turtle", desc: "Add later", imageFile: "turtle"),
        Animals(type: "Ocean3", name: "Whale", desc: "Add later", imageFile: "whale")
    ]

    private let defaultDesert = [
        Animals(type: "Desert1", name: "Camel", desc: "Add later", imageFile: "camel"),
        Animals(type: "Desert2", name: "Rattle Snake", desc: "Add later", imageFile: "rattlesnake"),
        Animals(type: "Desert3", name: "Fennec Fox", desc: "Add later", imageFile: "fennecfox")
    ]

    private let defaultArctic = [
        Animals(type: "Arctic1", name: "Arctic Bear", desc: "Add later", imageFile: "articbear"),
        Animals(type: "Arctic2", name: "Arctic Fox", desc: "Add later", imageFile: "articfox"),
        Animals(type: "Arctic3", name: "Walrus", desc: "Add later", imageFile: "walrus")
    ]

    //creation of dynamic arrays for each biome
    var forestAnimals: [Animals] = []
    var oceanAnimals: [Animals] = []
    var desertAnimals: [Animals] = []
    var arcticAnimals: [Animals] = []


    //loads animals from persistent storage using the StorageManager
    // if the forestAnimals is empty output the default arrays
    func loadData() {
        forestAnimals = StorageManager.shared.loadAnimals(key: forestKey)
        if forestAnimals.isEmpty { forestAnimals = defaultForest }

        oceanAnimals = StorageManager.shared.loadAnimals(key: oceanKey)
        if oceanAnimals.isEmpty { oceanAnimals = defaultOcean }

        desertAnimals = StorageManager.shared.loadAnimals(key: desertKey)
        if desertAnimals.isEmpty { desertAnimals = defaultDesert }

        arcticAnimals = StorageManager.shared.loadAnimals(key: arcticKey)
        if arcticAnimals.isEmpty { arcticAnimals = defaultArctic }
    }

    //each function saves the current animals array to storage using the biomes' key
    func saveForest() {
        StorageManager.shared.saveAnimals(forestAnimals, key: forestKey)
    }
    
    func saveOcean() {
        StorageManager.shared.saveAnimals(oceanAnimals, key: oceanKey)
    }
    
    func saveDesert() {
        StorageManager.shared.saveAnimals(desertAnimals, key: desertKey)
    }
    
    func saveArctic() {
        StorageManager.shared.saveAnimals(arcticAnimals, key: arcticKey)
    }
    
}
