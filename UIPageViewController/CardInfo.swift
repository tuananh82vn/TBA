//
//  CardInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CardInfo: NSObject {

    var Amount = Double()
    var PaymentMethod = 0
    var CardType = 0
    var NameOnCard = ""
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
    var ExpiryDate  = ""
    var Cvv = ""
    
    
    var AccountName = ""
    var BSB = ""
    var BSB1 = ""
    var BSB2 = ""
    var AccountNumber = ""

    var DebtorPaymentInstallment = ""

}

class UpdateCardInfo: NSObject {
    
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
}




