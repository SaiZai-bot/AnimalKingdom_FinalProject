//
//  Animals.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

// Make Animals class to be converted to/from Data (JSON)
class Animals: Codable {
    
    //creating of 4 properties to be used by 4 animal types (Forest, Desert, Ocean, Arctic)
    var type: String
    var name: String
    var desc: String
    var imageFile: String

    //
    init(type: String, name: String, desc: String, imageFile: String) {
        
        //initializers for the animals to be created
        self.type = type
        self.name = name
        self.desc = desc
        self.imageFile = imageFile
    }
    
}
