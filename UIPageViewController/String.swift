//
//  String.swift
//  UIPageViewController
//
//  Created by andy synotive on 8/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    
    func dateFromString(format: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "Australia/Melbourne")
        
        if let date = dateFormatter.dateFromString(self)
        {
            return date
        }
        else
        {
            return NSDate(timeIntervalSince1970: 0)
        }
    }
}

extension NSDate {
    
    func formattedWith(format:String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }

}