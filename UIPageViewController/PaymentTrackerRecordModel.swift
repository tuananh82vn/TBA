//
//  PaymentTrackerRecordModel.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation

class PaymentTrackerRecordModel : Serializable {
    
    var DueDate : String
    var Amount : String


    override init() {
        DueDate = ""
        Amount = ""
    }
}
