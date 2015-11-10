//
//  CustomTelrikViewCellTableViewCell.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class CustomTelrikViewCell: TKListViewCell {

    let lb_Remaining =  UILabel()
    let img_Status = UIImageView()
    let lb_Amount = UILabel()
    let lb_DueDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.img_Status.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.lb_DueDate.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_DueDate.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_DueDate.textAlignment = NSTextAlignment.Left
        
        self.lb_Amount.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_Amount.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_Amount.textAlignment = NSTextAlignment.Right

        self.lb_Remaining.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_Remaining.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_Remaining.textAlignment = NSTextAlignment.Right

        
        self.contentView.addSubview(lb_DueDate)
        self.contentView.addSubview(img_Status)
        self.contentView.addSubview(lb_Amount)
        self.contentView.addSubview(lb_Remaining)
        
        (self.backgroundView as! TKView).backgroundColor = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.lb_DueDate.frame = CGRectMake(0, 10, 90, 20)
        
        self.lb_Amount.frame = CGRectMake(95, 10, 75, 20)
        
        self.img_Status.frame = CGRectMake(175, 10, 80, 20)
        
        self.lb_Remaining.frame = CGRectMake(260, 10, 100, 20)
        
    }


}
