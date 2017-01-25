//
//  LoremIpsumGenerator.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class LoremIpsumGenerator: NSObject {
    
    let words = ["lorem", "ipsum", "dolor", "sit", "amet", "consectetuer", "adipiscing", "elit", "integer", "in", "mi", "a", "mauris"]
    let rows = NSMutableDictionary()
    
    func generateString(_ wordCount: NSInteger) -> NSString {
        let randomString = NSMutableString()
        for i in 0 ..< wordCount
        {
            let index : Int = Int(arc4random_uniform(UInt32(words.count)))
            randomString.append(words[index])
            randomString.append(" ")
        }
        return randomString
    }
    
    func randomString(_ wordCount: NSInteger, indexPath: IndexPath) -> NSString {
        var text : NSString? = rows.object(forKey: indexPath) as? NSString
        if(text == nil){
          text = generateString(wordCount)
          rows.setObject(text!, forKey: indexPath as NSCopying)
        }
        return text!
    }
}
