//
//  PaymentInfo.swift
//  UIPageViewController
//
//  Created by andy synotive on 15/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation


class PaymentInfo: NSObject {
    
    var card = CardInfo()
    var bank = BankInfo()
    var personalInfo = PersonalInfo()
    
    var RecType = ""
    var Errors = ""
    var IsSuccess = false
    
}