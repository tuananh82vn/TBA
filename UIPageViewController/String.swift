//
//  String.swift
//  UIPageViewController
//
//  Created by andy synotive on 8/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
        func indexDistance(of character: Character) -> Int? {
            guard let index = characters.index(of: character) else { return nil }
            return distance(from: startIndex, to: index)
        }
  
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    
    func dateFromString(_ format: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "Australia/Melbourne")
        
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        else
        {
            return Date(timeIntervalSince1970: 0)
        }
    }
    
    func dateFromString2(_ format: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "GMT")

        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        else
        {
            return Date(timeIntervalSince1970: 0)
        }
    }

    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func isPhoneNumber() -> Bool {
        
        
        let part = "(^1300\\d{6}$)|(^1800|1900|1902\\d{6}$)|(^0[2|3|7|8]{1}[0-9]{8}$)|(^13\\d{4}$)|(^04\\d{2,3}\\d{6}$)"
        
        //Matches 0732105432 | 1300333444 | 131313
        //Non-Matches 32105432 | 13000456
        
        let regex = try! NSRegularExpression(pattern: part,options: [.caseInsensitive])
            
        return regex.firstMatch(in: self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isEmailAddress() -> Bool {
    
        let part = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"

        let regex = try! NSRegularExpression(pattern: part,options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    

}


