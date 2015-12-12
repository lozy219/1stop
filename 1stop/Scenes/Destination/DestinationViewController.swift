//
//  DestinationViewController.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit

class DestinationViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "1 STOP"
        let listTab = self.tabBar.items![0] as UITabBarItem
        let mapTab = self.tabBar.items![1] as UITabBarItem
        
        listTab.title = "List"
        listTab.image = UIImage(named: "icon_list")
        mapTab.title = "Map"
        mapTab.image = UIImage(named: "icon_map")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
