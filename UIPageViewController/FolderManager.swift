//
//  FolderManager.swift
//  BoardMeeting
//
//  Created by synotivemac on 29/09/2015.
//  Copyright (c) 2015 Synotive. All rights reserved.
//
import UIKit
import Spring
import Foundation

public struct FolderManager {


    
    static func DeleteFile(filePath: String) -> Bool {
        
        
        let fileManager = NSFileManager()
        
        
        do {
            try fileManager.removeItemAtPath(filePath)
            
            return true
        } catch _ {
            //println("Failed to remove item at path \(filePath)")
            
            return false
        }
        //}
        
    }

 
}

