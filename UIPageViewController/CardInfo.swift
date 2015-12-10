//
//  CardInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CardInfo: NSObject {

    var Amount = Float()
    var CardType = 0
    var NameOnCard = ""
    var CardNumber = ""
    var ExpiryDate = NSDate()
    var CVV = ""

}


class BankInfo: NSObject {
    
    var Amount = Float()
    var AccountName = ""
    var BSB1 = ""
    var BSB2 = ""
    var AccountNumber = ""
    
}
