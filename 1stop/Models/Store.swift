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
    
    var currentBus: Bus?
    var currentStops: [String: Stop]?
    var currentStop: Stop?
    
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
    
    func addBus(number: String, direction: String, provider: String, type: String, stops: [String]) -> Bus {
        let b = Bus(number: number, direction: direction, provider: provider, type: type, stops: stops)
        self.allBuses[number] = b
        
        return b
    }
    
    func getStop(number: String) -> Stop? {
        return self.allStops[number]
    }
    
    func getBus(number: String) -> Bus? {
        return self.allBuses[number]
    }
    
    func chooseBus(number: String) -> Bool {
        if let bus = self.allBuses[number] {
            self.currentBus = bus
//            set current bus stops
//            self.currentStops =
            return true
        } else {
            return false
        }
    }
    
    func chooseStop(number: String) -> Bool {
        if let stop = self.currentStops![number] {
            self.currentStop = stop
            return true
        } else {
            return false
        }
    }
}
