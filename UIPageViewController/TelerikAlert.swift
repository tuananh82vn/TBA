//
//  TelerikAlert.swift
//  UIPageViewController
//
//  Created by andy synotive on 8/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation


struct TelerikAlert {
    

    
    static func ShowAlert(viewDisplay : UIView , title : String , message : String , style : String){
        
        let colors = [UIColor(red: 1, green: 0, blue: 0.282, alpha: 1),
            UIColor(red:1, green:0.733, blue:0, alpha:1),
            UIColor(red:0.478, green:0.988, blue:0.157, alpha:1),
            UIColor(red:0.231, green:0.678, blue:1, alpha:1)]
        
        let alert = TKAlert()
        
        alert.customFrame = CGRectMake(0, 0, viewDisplay.frame.size.width, 160)
        alert.style.contentSeparatorWidth = 0
        alert.style.titleColor = UIColor.whiteColor()
        alert.style.messageColor = UIColor.whiteColor()
        alert.style.cornerRadius = 0
        alert.style.showAnimation = TKAlertAnimation.SlideFromTop
        alert.style.dismissAnimation = TKAlertAnimation.SlideFromTop
        alert.style.backgroundStyle = TKAlertBackgroundStyle.None
        
        alert.alertView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        alert.dismissMode = TKAlertDismissMode.Tap
        
        
//        alert.addActionWithTitle("Close") { (TKAlert, TKAlertAction) -> Bool in
//            NSLog("closed")
//            return true
//        }
        
        alert.title = title
        alert.message = message
        
        if(style == "Error")
        {
            alert.contentView.fill = TKSolidFill(color: colors[0])
            alert.headerView.fill = TKSolidFill(color: colors[0])
        }
        else
            if(style == "Warning")
            {
                alert.contentView.fill = TKSolidFill(color: colors[1])
                alert.headerView.fill = TKSolidFill(color: colors[1])
            }
            else
                if(style == "Positive")
                {
                    alert.contentView.fill = TKSolidFill(color: colors[2])
                    alert.headerView.fill = TKSolidFill(color: colors[2])
                }
                else
                    if(style == "Info")
                    {
                        alert.contentView.fill = TKSolidFill(color: colors[3])
                        alert.headerView.fill = TKSolidFill(color: colors[3])
                    }

        alert.dismissTimeout = 3.2

        
        alert.show(true)
        
        
    }
}