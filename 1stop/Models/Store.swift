//
//  Store.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit
import MapKit

private let sharedStore = Store()

class Store: NSObject {
    var allStops: Dictionary<String, Stop> = [:]
    var allBuses: Dictionary<String, Bus> = [:]
    
    class var sharedInstance : Store {
        return sharedStore
    }
    
    override init() {
        super.init()
        
        if let path = NSBundle.mainBundle().pathForResource("bus-stops", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [[String: AnyObject]] {
                    
                    for stop: Dictionary in JSONObject {
                        let sNum = stop["no"] as! String
                        let sName = stop["name"] as! String
                        let sLat = stop["lat"] as! CLLocationDegrees
                        let sLng = stop["lng"] as! CLLocationDegrees
                        
                        self.addStop(sNum, name: sName, lat: sLat, lng: sLng)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func addStop(number: String, name: String, lat: CLLocationDegrees, lng: CLLocationDegrees) -> Stop {
        let s = Stop(number: number, name: name, latitude: lat, longitude: lng)
        self.allStops[number] = s
        
        return s
    }
    
    func addBus(number: String, direction: String, provider: String, type: String) -> Bus {
        let b = Bus(number: number, direction: direction, provider: provider, type: type)
        self.allBuses[number] = b
        
        return b
    }
    
    func getStop(number: String) -> Stop? {
        return allStops[number]
    }
    
    func getBus(number: String) -> Bus? {
        return allBuses[number]
    }
}
