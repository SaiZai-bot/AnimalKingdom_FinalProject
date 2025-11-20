//
//  Animals.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

// Define the structure for a single Animal record
// Codable protocol allows this class to be easily converted to and from Data (JSON) for storage purposes
class Animals: Codable {
    
    //creating of 4 properties to be used by 4 animal types (Forest, Desert, Ocean, Arctic)
    var type: String
    var name: String
    var desc: String
    var imageFile: String

    // Initializes a new instance of the Animal class
    init(type: String, name: String, desc: String, imageFile: String) {
        
        // Assign the input parameters to the respective properties of the class instance
        self.type = type
        self.name = name
        self.desc = desc
        self.imageFile = imageFile
    }
    
}
