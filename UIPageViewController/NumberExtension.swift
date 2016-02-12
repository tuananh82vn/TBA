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
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}