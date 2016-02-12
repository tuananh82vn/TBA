//
//  DebtorPaymentInstallment.swift
//  UIPageViewController
//
//  Created by andy synotive on 12/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


class DebtorPaymentInstallment : Serializable {
    var PaymentDate : String
    var Amount : Double
    
    override init() {
        PaymentDate = ""
        Amount = 0
    }
}