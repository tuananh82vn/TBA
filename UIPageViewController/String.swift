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
    
    func dateFromString2(format: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "GMT")

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
    
    func isPhoneNumber() -> Bool {
        
        
        var part = "(^1300\\d{6}$)|(^1800|1900|1902\\d{6}$)|(^0[2|3|7|8]{1}[0-9]{8}$)|(^13\\d{4}$)|(^04\\d{2,3}\\d{6}$)"
        
        //Matches 0732105432 | 1300333444 | 131313
        //Non-Matches 32105432 | 13000456
        
        let regex = try! NSRegularExpression(pattern: part,options: [.CaseInsensitive])
            
        return regex.firstMatchInString(self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isEmailAddress() -> Bool {
    
        var part = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"

        let regex = try! NSRegularExpression(pattern: part,options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    

}


