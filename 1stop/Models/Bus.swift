//
//  Bus.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit

class Bus: NSObject {
    var number: String
    var direction: String
    var provider: String
    var type: String
    
    init(number: String, direction: String, provider: String, type: String) {
        self.number = number
        self.direction = direction
        self.provider = provider
        self.type = type
    }
}
