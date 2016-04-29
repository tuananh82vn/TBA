//
//  CardInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CardInfo: NSObject {

    var Amount = Double()
    var CardType = 0
    var NameOnCard = ""
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
    var ExpiryDate  = ""
    var Cvv = ""
    var DebtorPaymentInstallment = ""

}

class UpdateCardInfo: NSObject {
    
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
}




