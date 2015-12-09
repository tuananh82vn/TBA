//
//  CardInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CardInfo: NSObject {

    var Amount = Float()
    var NameOnCard = ""
    var CardNumber = ""
    var ExpiryDate = NSDate()
    var CVV = ""

}


class BankInfo: NSObject {
    
    var Amount = Float()
    var BankAccountName = ""
    var BankAccountBSB1 = ""
    var BankAccountBSB2 = ""
    
}
