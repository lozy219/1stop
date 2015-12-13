//
//  LocationManager.swift
//  1stop
//
//  Created by Long Pan on 13/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import Foundation
import MapKit

private let locationManager = CLLocationManager()

class LocationManager {
    static var sharedInstance: CLLocationManager {
        return locationManager
    }
}