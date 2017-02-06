//
//  DateMonthEditor.swift
//  UIPageViewController
//
//  Created by Anh Pham on 2/2/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import Foundation


class DateMonthEditor: TKDataFormDatePickerEditor {
    
    
    override init(property: TKEntityProperty, owner: TKDataForm) {
        super.init(property: property, owner: owner)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
}
