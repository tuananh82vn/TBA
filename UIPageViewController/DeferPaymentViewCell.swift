//
//  PaymentTrackerViewCell.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class DeferPaymentViewCell: UITableViewCell {
    
//    var lb_Amount: UILabel!
//    var lb_DueDate: UILabel!
//    var lb_Defer: UILabel!
//    var img_Status : UIImageView!
    
    @IBOutlet weak var img_Status: UIImageView!
    @IBOutlet weak var lb_Defer: UILabel!
    @IBOutlet weak var lb_Amount: UILabel!
    @IBOutlet weak var lb_DueDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    func setupLabel(iphone : String){
//        
//        if(iphone == "iPhone 6s Plus" || iphone == "iPhone 6 Plus" ){
//            
//            self.lb_DueDate.frame = CGRectMake(0, 0, 100, 44)
//            
//            self.lb_Amount.frame = CGRectMake(120, 0, 100, 44)
//            
//            self.lb_Defer.frame = CGRectMake(240, 0, 120, 44)
//            
//            self.img_Status.frame = CGRectMake(350, 10, 21, 21)
//            
//        }
//        else if(iphone == "iPhone 6s" || iphone == "iPhone 6" ){
//            
//            self.lb_DueDate.frame = CGRectMake(0, 0, 90, 44)
//            
//            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 15)
//            
//            
//            self.lb_Amount.frame = CGRectMake(120, 0, 90, 44)
//            
//            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 15)
//            
//            
//            self.lb_Defer.frame = CGRectMake(230, 0, 100, 44)
//            
//            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 15)
//            
//            self.img_Status.frame = CGRectMake(235, 0, 44, 44)
//
//        }
//        else if(iphone == "iPhone 5" || iphone == "iPhone 5s"  )
//        {
//            self.lb_DueDate.frame = CGRectMake(0, 0, 80, 44)
//            
//            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 12)
//            
//            
//            self.lb_Amount.frame = CGRectMake(100, 0, 80, 44)
//            
//            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 12)
//            
//            
//            self.lb_Defer.frame = CGRectMake(190, 0, 90, 44)
//            
//            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 12)
//            
//            self.img_Status.frame = CGRectMake(195, 0, 44, 44)
//
//        }
//        else if(iphone == "iPhone 4s" || iphone == "iPhone 4")
//        {
//            
//        }
//        else if(iphone == "Simulator")
//        {
//            self.lb_DueDate.frame = CGRectMake(0, 0, 90, 44)
//            
//            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 15)
//
//            
//            self.lb_Amount.frame = CGRectMake(120, 0, 90, 44)
//            
//            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 15)
//
//            
//            self.lb_Defer.frame = CGRectMake(230, 0, 100, 44)
//            
//            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 15)
//
//        }
//        
//    }
    
}
