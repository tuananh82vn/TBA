//
//  PaymentTrackerViewCell.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PaymentTrackerViewCell: UITableViewCell {

    @IBOutlet weak var lb_Remaining: UILabel!
    @IBOutlet weak var img_Status: UIImageView!
    @IBOutlet weak var lb_Amount: UILabel!
    @IBOutlet weak var lb_DueDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
