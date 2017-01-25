//
//  InboxItemViewCell.swift
//  UIPageViewController
//
//  Created by andy synotive on 27/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


class InboxItemViewCell: UITableViewCell {
    
    @IBOutlet weak var img_Status: UIImageView!
    @IBOutlet weak var lb_Date: UILabel!
    @IBOutlet weak var lb_Type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
