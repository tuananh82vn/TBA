//
//  PaymentReturnModel.swift
//  UIPageViewController
//
//  Created by andy synotive on 11/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import Foundation


class PaymentReturnModel {
    
    var PaymentId : Int
    var Item : String
    var ClientName : String
    var Name : String
    var Date : String
    var Time : String
    var Amount : String
    var ReceiptNumber : String
    var TransactionDescription : String
    
    var Errors : [Error]
    var IsSuccess : Bool
    
    init() {
        PaymentId = 0
        Item = ""
        Name = ""
        ClientName = ""
        Date = ""
        Time = ""
        Amount = ""
        ReceiptNumber = ""
        TransactionDescription = ""
        
        Errors = [Error]()
        IsSuccess = false
    }
}