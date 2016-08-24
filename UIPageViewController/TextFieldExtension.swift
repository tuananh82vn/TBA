//
//  TextFieldExtension.swift
//  UIPageViewController
//
//  Created by andy synotive on 24/08/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


private var maxLengthDictionary = [UITextField:Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = maxLengthDictionary[self] {
                return length
            } else {
                return Int.max
            }
        }
        set {
            maxLengthDictionary[self] = newValue
            addTarget(self, action: "checkMaxLength:", forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    func checkMaxLength(sender: UITextField) {
        let newText = sender.text
        if newText?.length > maxLength {
            let cursorPosition = selectedTextRange
            text = (newText! as NSString).substringWithRange(NSRange(location: 0, length: maxLength))
            selectedTextRange = cursorPosition
        }
    }
}