//
//  DestinationListTableViewCell.swift
//  1stop
//
//  Created by Lei Mingyu on 13/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit

class DestinationListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
