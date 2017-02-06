//
//  MethodExtension.swift
//  UIPageViewController
//
//  Created by Anh Pham on 2/2/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import Foundation




func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}
