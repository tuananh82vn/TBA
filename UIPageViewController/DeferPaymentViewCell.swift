//
//  PaymentTrackerViewCell.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class DeferPaymentViewCell: TKListViewCell {
    
    var lb_Amount: UILabel!
    var lb_DueDate: UILabel!
    var lb_Defer: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lb_DueDate = UILabel()
        self.lb_DueDate.textColor = UIColor.blackColor()
        self.addSubview(self.lb_DueDate)
        
        self.lb_Amount = UILabel()
        self.lb_Amount.textColor = UIColor.blackColor()
        self.addSubview(self.lb_Amount)
        
        self.lb_Defer = UILabel()
        self.lb_Defer.textColor = UIColor.blackColor()

        self.addSubview(self.lb_Defer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
        self.lb_DueDate.frame = CGRectMake(0, 0, 100, 44)
        self.lb_DueDate.textAlignment = NSTextAlignment.Right

        self.lb_Amount.frame = CGRectMake(120, 0, 100, 44)
        self.lb_Amount.textAlignment = NSTextAlignment.Right

        
        self.lb_Defer.frame = CGRectMake(240, 0, 120, 44)
        self.lb_Defer.textAlignment = NSTextAlignment.Center

        
    }
    
}
