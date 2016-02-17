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
    
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
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
    
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }

}

