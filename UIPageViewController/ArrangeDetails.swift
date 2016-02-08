//
//  ArrangeDetails.swift
//  UIPageViewController
//
//  Created by andy synotive on 4/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


class ArrangeDetails {
    
    var ReferenceNumber : String
    var ArrangeAmount : Float
    var Frequency : String
    var PaidAmount : Float
    var LeftToPay : Float
    var Status : String
    var OverdueAmount : Float
    var NextInstalmentDate : String
    
    var IsSuccess : Bool
    var Error : String
    init() {
        ReferenceNumber = ""
        ArrangeAmount = 0
        Frequency = ""
        PaidAmount = 0
        LeftToPay = 0
        Status = ""
        OverdueAmount = 0
        NextInstalmentDate = ""
        IsSuccess = false
        Error = ""
    }
}