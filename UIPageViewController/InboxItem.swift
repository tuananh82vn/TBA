//
//  InboxItem.swift
//  UIPageViewController
//
//  Created by andy synotive on 27/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import Foundation


class InboxItem: NSObject {
    
    var Date = ""
    
    var ItemType = ""
    
    var Content = ""

    var MessageNo : Int32 = 0
    
    var Status = ""
    
    var IsLocal = false
    
    var FileName = ""
    
}

class InboxItemList: NSObject {
    
    var InboxList = [InboxItem]()
    var IsSuccess = false
    var Errors = [Error]()
    
}
