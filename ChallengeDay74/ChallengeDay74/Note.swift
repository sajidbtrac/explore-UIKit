//
//  Note.swift
//  ChallengeDay74
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class Note: NSObject, Codable {
    var title: String
    var details: String
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}
