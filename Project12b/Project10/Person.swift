//
//  Person.swift
//  Project10
//
//  Created by BTSL.SAJID on 12/6/23.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
