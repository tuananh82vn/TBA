//
//  NUmberExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 12/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


extension Float {
    func formatWithDecimal(_ fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        let number : NSNumber = self as NSNumber
        
        return formatter.string(from: number)!
    }
}

extension Double {
//    /// Rounds the double to decimal places value
//    mutating func roundWith2Decimal() -> Double {
//        let divisor = pow(10.0, Double(2))
//        
//        let temp = round(self * divisor) / divisor
//        
//        let tempString = String(format: "%.2f", temp)
//        
//        return tempString.doubleValue
//    }
    
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
//    mutating func roundToPlaces(_ places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return round(self * divisor) / divisor
//    }
    
    func formatWithDecimal(_ fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        let number : NSNumber = self as NSNumber

        return formatter.string(from: number)!
    }
    
    func formatAsCurrency() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_AU")
        
        let number : NSNumber = self as NSNumber
        
        return formatter.string(from: number)!
    }
    
    
}


extension String {
    func formatWithDecimal(_ fractionDigits:Int) -> NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.number(from: self)
    }
}
