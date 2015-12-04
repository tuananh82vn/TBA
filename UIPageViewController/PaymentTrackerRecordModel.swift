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
    var PaymentStatusId : Int
    var Remaining : String
    var PaidDetail : String
    var DeptCode : String

    override init() {
        DueDate = ""
        Amount = ""
        PaymentStatusId = 0
        Remaining = ""
        PaidDetail = ""
        DeptCode = ""
    }
}
