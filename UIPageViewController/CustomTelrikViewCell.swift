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
    let lb_PaidDetail = UILabel()
    let lb_DeptCode = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.img_Status.contentMode = UIViewContentMode.scaleAspectFit
        
        self.lb_DueDate.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_DueDate.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_DueDate.textAlignment = NSTextAlignment.left
        
        self.lb_Amount.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_Amount.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_Amount.textAlignment = NSTextAlignment.right

        self.lb_Remaining.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_Remaining.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_Remaining.textAlignment = NSTextAlignment.right
        
        self.lb_PaidDetail.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_PaidDetail.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_PaidDetail.textAlignment = NSTextAlignment.left
        
        self.lb_DeptCode.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.lb_DeptCode.font = UIFont(name:"HelveticaNeue", size:13)
        self.lb_DeptCode.textAlignment = NSTextAlignment.left

        
        self.contentView.addSubview(lb_DueDate)
        self.contentView.addSubview(img_Status)
        self.contentView.addSubview(lb_Amount)
        self.contentView.addSubview(lb_Remaining)
        self.contentView.addSubview(lb_PaidDetail)
        self.contentView.addSubview(lb_DeptCode)

        
        (self.backgroundView as! TKView).backgroundColor = UIColor.white
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.lb_DueDate.frame = CGRect(x: 0, y: 10, width: 90, height: 20)
        
        self.lb_Amount.frame = CGRect(x: 95, y: 10, width: 75, height: 20)
        
        self.img_Status.frame = CGRect(x: 175, y: 10, width: 80, height: 20)
        
        self.lb_Remaining.frame = CGRect(x: 260, y: 10, width: 100, height: 20)
        
        self.lb_PaidDetail.frame = CGRect(x: 0, y: 40, width: 150, height: 20)
        
        self.lb_DeptCode.frame = CGRect(x: 0, y: 60, width: 150, height: 20)

    }


}
