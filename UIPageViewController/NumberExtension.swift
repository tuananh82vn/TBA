//
//  NUmberExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 12/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


extension Float {
    func formatWithDecimal(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundWith2Decimal() -> Double {
        let divisor = pow(10.0, Double(2))
        
        let temp = round(self * divisor) / divisor
        
        let tempString = String(format: "%.2f", temp)
        
        return tempString.doubleValue
    }
}