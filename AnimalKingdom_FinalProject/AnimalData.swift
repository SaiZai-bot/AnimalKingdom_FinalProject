//
//  AnimalData.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/17/25.
//

import UIKit

class AnimalData {
    static let shared = AnimalData()
    private init(){}
    
    var forestAnimals: [Animals] = [
        Animals(type: "Forest1", name: "Bear", desc: "Add later", imageFile: "bear"),
        Animals(type: "Forest2", name: "Fox", desc: "Add later", imageFile: "fox"),
        Animals(type: "Forest3", name: "Squirrel", desc: "Add later", imageFile: "squirrel")
    ]
    
    var oceanAnimals: [Animals] = [
        Animals(type: "Ocean1", name: "Octopus", desc: "Add later", imageFile: "octopus"),
        Animals(type: "Ocean2", name: "Turtle", desc: "Add later", imageFile: "turtle"),
        Animals(type: "Ocean3", name: "Whale", desc: "Add later", imageFile: "whale")
    ]
    
    var desertAnimals: [Animals] = [
        Animals(type: "Desert1", name: "Camel", desc: "Add later", imageFile: "camel"),
        Animals(type: "Desert2", name: "Rattle Snake", desc: "Add later", imageFile: "rattlesnake"),
        Animals(type: "Desertt3", name: "Fennec Fox", desc: "Add later", imageFile: "fennecfox")
    ]
    
    var arcticAnimals: [Animals] = [
        Animals(type: "Artic1", name: "Artic Bear", desc: "Add later", imageFile: "articbear"),
        Animals(type: "Artic2", name: "Artic Fox", desc: "Add later", imageFile: "articfox"),
        Animals(type: "Artic3", name: "Walrus", desc: "Add later", imageFile: "walrus")
    ]
    
}
