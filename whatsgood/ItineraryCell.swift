//
//  ItineraryCell.swift
//  What's Good?
//
//  Created by Zach Jiroun on 1/18/15.
//  Copyright (c) 2015 Zach Jiroun. All rights reserved.
//

import Foundation
import UIKit

class ItineraryCell: UITableViewCell
{
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var ratingField: UILabel!
    @IBOutlet weak var distanceField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}