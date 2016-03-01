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
        self.lb_DueDate.textAlignment = NSTextAlignment.Center

        self.contentView.addSubview(self.lb_DueDate)
        
        self.lb_Amount = UILabel()
        self.lb_Amount.textColor = UIColor.blackColor()
        self.lb_Amount.textAlignment = NSTextAlignment.Center

        self.contentView.addSubview(self.lb_Amount)
        
        self.lb_Defer = UILabel()
        self.lb_Defer.textColor = UIColor.blackColor()
        self.lb_Defer.textAlignment = NSTextAlignment.Center

        self.contentView.addSubview(self.lb_Defer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        setupLabel(LocalStore.accessDeviceName());



        
    }
    
    func setupLabel(iphone : String){
        
        if(iphone == "iPhone 6s Plus" || iphone == "iPhone 6 Plus" ){
            
            self.lb_DueDate.frame = CGRectMake(0, 0, 100, 44)
            
            self.lb_Amount.frame = CGRectMake(120, 0, 100, 44)
            
            self.lb_Defer.frame = CGRectMake(240, 0, 120, 44)
        }
        else if(iphone == "iPhone 6s" || iphone == "iPhone 6" ){
            
            self.lb_DueDate.frame = CGRectMake(0, 0, 90, 44)
            
            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 15)
            
            
            self.lb_Amount.frame = CGRectMake(120, 0, 90, 44)
            
            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 15)
            
            
            self.lb_Defer.frame = CGRectMake(230, 0, 100, 44)
            
            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 15)
        }
        else if(iphone == "iPhone 5" || iphone == "iPhone 5s"  )
        {
            self.lb_DueDate.frame = CGRectMake(0, 0, 80, 44)
            
            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 12)
            
            
            self.lb_Amount.frame = CGRectMake(100, 0, 80, 44)
            
            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 12)
            
            
            self.lb_Defer.frame = CGRectMake(190, 0, 90, 44)
            
            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 12)
        }
        else if(iphone == "iPhone 4s" || iphone == "iPhone 4")
        {
            
        }
        else if(iphone == "Simulator")
        {
            self.lb_DueDate.frame = CGRectMake(0, 0, 90, 44)
            
            self.lb_DueDate.font = UIFont(name: self.lb_DueDate.font.fontName, size: 15)

            
            self.lb_Amount.frame = CGRectMake(120, 0, 90, 44)
            
            self.lb_Amount.font = UIFont(name: self.lb_Amount.font.fontName, size: 15)

            
            self.lb_Defer.frame = CGRectMake(230, 0, 100, 44)
            
            self.lb_Defer.font = UIFont(name: self.lb_Defer.font.fontName, size: 15)

        }
        
    }
    
}
