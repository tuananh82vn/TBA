//
//  FolderManager.swift
//  BoardMeeting
//
//  Created by synotivemac on 29/09/2015.
//  Copyright (c) 2015 Synotive. All rights reserved.
//
import UIKit
import Foundation

public struct FolderManager {


    
    static func DeleteFile(_ filePath: String) -> Bool {
        
        
        let fileManager = FileManager()
        
        
        do {
            try fileManager.removeItem(atPath: filePath)
            
            return true
        } catch _ {
            //println("Failed to remove item at path \(filePath)")
            
            return false
        }
        //}
        
    }

 
}

