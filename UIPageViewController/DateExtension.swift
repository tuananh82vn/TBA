//
//  DateExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 11/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        
        
//        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
//        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
//        
//        //Return Result
//        return dateWithDaysAdded
        
        let components: NSDateComponents = NSDateComponents()

        components.setValue(daysToAdd, forComponent: NSCalendarUnit.Day);
        
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0))!
        
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}