//
//  String.swift
//  UIPageViewController
//
//  Created by andy synotive on 8/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

extension NSDate {
    
    func formattedWith(format:String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
}