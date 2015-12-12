//
//  Stop.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit
import MapKit

class Stop: NSObject {
    var number: String
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(number: String, name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.number = number
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
