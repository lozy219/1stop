//
//  SearchViewController.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.grayColor().CGColor
        border.frame = CGRect(x: 0, y: self.textField.frame.size.height - width,
            width: UIScreen.mainScreen().bounds.width, height: self.textField.frame.size.height)
        
        border.borderWidth = width
        self.textField.layer.addSublayer(border)
        self.textField.layer.masksToBounds = true
        
        self.textField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let busNumber = self.textField.text!
        Store.sharedInstance.chooseBus(busNumber)
        
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DestinationViewController")
        self.navigationController?.pushViewController(destinationVC, animated: false)
        return true
    }
}
