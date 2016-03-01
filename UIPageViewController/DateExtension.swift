//
//  DateExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 11/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


extension NSDate {
    
    
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyyMMdd"
        dateStringFormatter.timeZone = NSTimeZone(name: "GMT")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
    
    func formattedWith(format:String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
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

        let components: NSDateComponents = NSDateComponents()

        components.setValue(daysToAdd, forComponent: NSCalendarUnit.Day);
        
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0))!
        
    }
    
    func addMonths(monthToAdd: Int) -> NSDate {
        
        let components: NSDateComponents = NSDateComponents()
        
        components.setValue(monthToAdd, forComponent: NSCalendarUnit.Month);
        
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0))!
        
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}