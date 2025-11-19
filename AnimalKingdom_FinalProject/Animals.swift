//
//  Animals.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class Animals: Codable {
    var type: String
    var name: String
    var desc: String
    var imageFile: String

    init(type: String, name: String, desc: String, imageFile: String) {
        self.type = type
        self.name = name
        self.desc = desc
        self.imageFile = imageFile
    }
    
}
