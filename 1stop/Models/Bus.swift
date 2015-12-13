//
//  Bus.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit
import CoreLocation

class Bus: NSObject {
    var number: String
    var name: String
    var direction: String
    var provider: String?
    var type: String
    var stops: [Stop]?
    var route: [CLLocationCoordinate2D]?
    
    init(number: String, name: String, direction: String, provider: String?, type: String, stops: [Stop]?, route: [CLLocationCoordinate2D]?) {
        self.number = number
        self.name = name
        self.direction = direction
        self.provider = provider
        self.type = type
        self.stops = stops
        self.route = route
    }
}
