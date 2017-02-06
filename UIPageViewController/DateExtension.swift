//
//  DateExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 11/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


extension Date {
    
    
    
//    init(dateString:String) {
//        let dateStringFormatter = DateFormatter()
//        dateStringFormatter.dateFormat = "yyyyMMdd"
//        dateStringFormatter.timeZone = TimeZone(identifier: "GMT")
//        let d = dateStringFormatter.date(from: dateString)!
//        (self as NSDate).type(of:, init)(timeInterval:0, since:d)
//    }
    
    func formattedWith(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(_ daysToAdd: Int) -> Date {

        let components: DateComponents = DateComponents()

        (components as NSDateComponents).setValue(daysToAdd, forComponent: NSCalendar.Unit.day);
        
        return (Calendar.current as NSCalendar).date(byAdding: components, to: self, options: NSCalendar.Options(rawValue: 0))!
        
    }
    
    func addMonths(_ monthToAdd: Int) -> Date {
        
        let components: DateComponents = DateComponents()
        
        (components as NSDateComponents).setValue(monthToAdd, forComponent: NSCalendar.Unit.month);
        
        return (Calendar.current as NSCalendar).date(byAdding: components, to: self, options: NSCalendar.Options(rawValue: 0))!
        
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}



extension Date {
    
    init(year: Int,
         month: Int,
         day: Int,
         hour: Int = 0,
         minute: Int = 0,
         second: Int = 0,
         timeZone: TimeZone = TimeZone(abbreviation: "UTC")!) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.timeZone = timeZone
        self = Calendar.current.date(from: components)!
    }
    
    init(dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zz"
        self = formatter.date(from: dateString)!
    }
    
}




extension Int {
    
    var second: DateComponents {
        var components = DateComponents()
        components.second = self;
        return components
    }
    
    var seconds: DateComponents {
        return self.second
    }
    
    var minute: DateComponents {
        var components = DateComponents()
        components.minute = self;
        return components
    }
    
    var minutes: DateComponents {
        return self.minute
    }
    
    var hour: DateComponents {
        var components = DateComponents()
        components.hour = self;
        return components
    }
    
    var hours: DateComponents {
        return self.hour
    }
    
    var day: DateComponents {
        var components = DateComponents()
        components.day = self;
        return components
    }
    
    var days: DateComponents {
        return self.day
    }
    
    var week: DateComponents {
        var components = DateComponents()
        components.weekOfYear = self;
        return components
    }
    
    var weeks: DateComponents {
        return self.week
    }
    
    var month: DateComponents {
        var components = DateComponents()
        components.month = self;
        return components
    }
    
    var months: DateComponents {
        return self.month
    }
    
    var year: DateComponents {
        var components = DateComponents()
        components.year = self;
        return components
    }
    
    var years: DateComponents {
        return self.year
    }
    
}



extension DateComponents {
    
    var fromNow: Date {
        return Calendar.current.date(byAdding: self,
                                     to: Date())!
    }
    
    var ago: Date {
        return Calendar.current.date(byAdding: -self,
                                     to: Date())!
    }
    
}


