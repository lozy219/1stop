//
//  RoutePoint.swift
//  1stop
//
//  Created by Long Pan on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import Foundation
import MapKit

class RoutePoint: NSObject {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let identifier: String
    
    init(c: CLLocationCoordinate2D, title: String, identifier: String) {
        self.coordinate = c
        self.title = title
        self.identifier = identifier
    }
}
