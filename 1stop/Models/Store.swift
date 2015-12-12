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
        
        // load all stops
        if let path = NSBundle.mainBundle().pathForResource("bus-stops", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [[String: AnyObject]] {
                    
                    for stop: Dictionary in JSONObject {
                        let sNum = stop["no"] as! String
                        let sName = stop["name"] as! String
                        let sLat = stop["lat"]!.doubleValue
                        let sLng = stop["lng"]!.doubleValue
                        
                        self.addStop(sNum, name: sName, lat: sLat, lng: sLng)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid bus stop filename/path.")
        }
        
        // load all buses
        if let path = NSBundle.mainBundle().pathForResource("bus-services", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? Dictionary<String, AnyObject> {
                    
                    let types = JSONObject["types"]!.allValues

                    for (var i = 0; i < JSONObject["services"]!.count; i++) {
                        let service = JSONObject["services"]![i]
                        
                        let bNumber = service["no"] as! String
                        let bOperator = service["operator"]!!.stringValue
                        let bName = service["name"] as! String
                        let bType = types[service["type"]!!.integerValue] as! String
                        let bDirection = service["routes"]!!.stringValue
                        
                        self.addBus(bNumber, name: bName, direction: bDirection, provider: bOperator, type: bType)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid bus stop filename/path.")
        }
    }
    
    func addStop(number: String, name: String, lat: CLLocationDegrees, lng: CLLocationDegrees) -> Stop {
        let s = Stop(number: number, name: name, latitude: lat, longitude: lng)
        self.allStops[number] = s
        
        return s
    }
    
    func addBus(number: String, name: String, direction: String, provider: String?, type: String) -> Bus {
        let b = Bus(number: number, name: name, direction: direction, provider: provider, type: type)
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
