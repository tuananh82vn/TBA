//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: LocalDatabase.getPath("inbox.sqlite"))
        }
        return sharedInstance
    }
    
    func insertInboxItem(_ studentInfo: InboxItem) -> Bool {
        
        sharedInstance.database!.open()

        var isInserted = false
            
        isInserted = sharedInstance.database!.executeUpdate("INSERT INTO inbox (Date, Type , MessageNo , Status, Content , IsLocal , FileName1 ) VALUES (?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [studentInfo.Date, studentInfo.ItemType, studentInfo.MessageNo.description, studentInfo.Status, studentInfo.Content, studentInfo.IsLocal, studentInfo.FileName])
        
        sharedInstance.database!.close()
        
        return isInserted
    }
    
    func updateInboxItem(_ studentInfo: InboxItem) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE inbox SET Content=?, Status=?, IsLocal=? , FileName1=? WHERE MessageNo=?", withArgumentsIn: [studentInfo.Content,studentInfo.Status, studentInfo.IsLocal, studentInfo.FileName, studentInfo.MessageNo.description])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteInboxItem(_ studentInfo: InboxItem) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM inbox WHERE MessageNo=?", withArgumentsIn: [studentInfo.MessageNo.description])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func deleteAllInboxItem() -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM inbox", withArgumentsIn: nil)
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllInboxItem() -> [InboxItem] {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM inbox", withArgumentsIn: nil)
        
        var InboxList = [InboxItem]()

        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : InboxItem = InboxItem()
                studentInfo.Date = resultSet.string(forColumn: "Date")
                studentInfo.ItemType = resultSet.string(forColumn: "Type")
                studentInfo.Status = resultSet.string(forColumn: "Status")
                studentInfo.MessageNo = Int32(resultSet.string(forColumn: "MessageNo"))!
                studentInfo.Content = resultSet.string(forColumn: "Content")
                studentInfo.IsLocal = resultSet.bool(forColumn: "IsLocal")
                studentInfo.FileName = resultSet.string(forColumn: "FileName1")
                InboxList.append(studentInfo)
            }
        }
        sharedInstance.database!.close()
        return InboxList
    }
}
