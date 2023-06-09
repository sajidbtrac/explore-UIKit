//
//  Capital.swift
//  Project16
//
//  Created by BTSL.SAJID on 15/6/23.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let info: String
    let WikipediaURLString: String
    
    init(title: String?, coordinate: CLLocationCoordinate2D, info: String, WikipediaURLString: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.WikipediaURLString = WikipediaURLString
    }
}
