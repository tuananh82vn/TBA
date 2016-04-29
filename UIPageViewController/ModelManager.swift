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
    
    func insertInboxItem(studentInfo: InboxItem) -> Bool {
        
        sharedInstance.database!.open()

        var isInserted = false
            
        isInserted = sharedInstance.database!.executeUpdate("INSERT INTO inbox (Date, Type , MessageNo , Status, Content , IsLocal , FileName ) VALUES (?, ?, ? , ?, ? , ?)", withArgumentsInArray: [studentInfo.Date, studentInfo.Type, studentInfo.MessageNo.description, studentInfo.Status, studentInfo.Content, studentInfo.IsLocal, studentInfo.FileName])
        
        sharedInstance.database!.close()
        
        return isInserted
    }
    
    func updateInboxItem(studentInfo: InboxItem) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE inbox SET Content=?, Status=?, IsLocal= ? , FileName = ? WHERE MessageNo=?", withArgumentsInArray: [studentInfo.Content,studentInfo.Status, studentInfo.MessageNo.description, studentInfo.IsLocal , studentInfo.FileName])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteInboxItem(studentInfo: InboxItem) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM inbox WHERE MessageNo=?", withArgumentsInArray: [studentInfo.MessageNo.description])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func deleteAllInboxItem() -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM inbox", withArgumentsInArray: nil)
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllInboxItem() -> [InboxItem] {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM inbox", withArgumentsInArray: nil)
        
        var InboxList = [InboxItem]()

        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : InboxItem = InboxItem()
                studentInfo.Date = resultSet.stringForColumn("Date")
                studentInfo.Type = resultSet.stringForColumn("Type")
                studentInfo.Status = resultSet.stringForColumn("Status")
                studentInfo.MessageNo = Int32(resultSet.stringForColumn("MessageNo"))!
                studentInfo.Content = resultSet.stringForColumn("Content")
                studentInfo.IsLocal = resultSet.boolForColumn("IsLocal")
                studentInfo.FileName = resultSet.stringForColumn("FileName")
                InboxList.append(studentInfo)
            }
        }
        sharedInstance.database!.close()
        return InboxList
    }
}
