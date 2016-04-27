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
    var Type = ""
    var MessageNo = ""
    
}

class InboxItemList: NSObject {
    
    var InboxList = [InboxItem]()
    var IsSuccess = false
    var Errors = [Error]()
    
}