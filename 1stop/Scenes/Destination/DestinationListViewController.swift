//
//  DestinationListViewController.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit

class DestinationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTableView: UITableView!
    private var previousCheckedStation: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.registerNib(UINib(nibName: "DestinationListTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinationListTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.listTableView.cellForRowAtIndexPath(indexPath) as! DestinationListTableViewCell
        if self.previousCheckedStation != nil {
            let prevCell = self.listTableView.cellForRowAtIndexPath(previousCheckedStation!)
            prevCell?.accessoryType = UITableViewCellAccessoryType.None
        }
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        self.previousCheckedStation = indexPath
        Store.sharedInstance.chooseStop(cell.numberLabel.text!)
        
        let alert = UIAlertController(title: "Set \(cell.nameLabel.text!) as your destination", message: "", preferredStyle: .Alert)
        
        let confirm = UIAlertAction(title: "Yes!", style: .Default, handler: {
            (let action) -> Void in
            let tababarController = self.parentViewController as? UITabBarController
            tababarController!.selectedIndex = 1
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Store.sharedInstance.currentBus!.stops!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DestinationListTableViewCell", forIndexPath: indexPath) as! DestinationListTableViewCell
        let stops = Store.sharedInstance.currentBus!.stops
        
        if previousCheckedStation?.row == indexPath.row {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        cell.nameLabel.text = stops![indexPath.row].name
        cell.numberLabel.text = stops![indexPath.row].number
        return cell
    }
}

