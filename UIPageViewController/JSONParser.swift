//
//  JSONParser.swift
//  DesignerNewsApp
//
//  Created by André Schneider on 20.01.15.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import Foundation

struct JSONParser {
    
    static func parseError(story: NSArray) -> [Error] {
        
        var ErrorArray = [Error]()
        
        if let Items = story as Array? {
            
            for var index = 0; index < Items.count; ++index {
                
                if let Item = Items[index] as? NSDictionary {
                    
                    let temp = JSONParser.parseObjectError(Item as NSDictionary)
                    
                    ErrorArray.append(temp)
                }
            }
        }
        
        return ErrorArray
    }
    
    static func parseObjectError(story: NSDictionary) -> Error {
        
        let Object =  Error()
        
        Object.ErrorMessage = story["ErrorMessage"] as? String ?? ""
        
        return Object
    }
    
    static func parseHistoryPaymentTracker(story: NSArray) -> [PaymentTrackerRecordModel] {
        
        var ErrorArray = [PaymentTrackerRecordModel]()
        
        if let Items = story as Array? {
            
            for var index = 0; index < Items.count; ++index {
                
                if let Item = Items[index] as? NSDictionary {
                    
                    let temp = JSONParser.parseObjectHistoryPaymentTracker(Item as NSDictionary)
                    
                    ErrorArray.append(temp)
                }
            }
        }
        
        return ErrorArray
    }
    
    static func parseInboxList(story: NSArray) -> [InboxItem] {
        
        var ErrorArray = [InboxItem]()
        
        if let Items = story as Array? {
            
            for var index = 0; index < Items.count; ++index {
                
                if let Item = Items[index] as? NSDictionary {
                    
                    let temp = JSONParser.parseObjectInboxItem(Item as NSDictionary)
                    
                    ErrorArray.append(temp)
                }
            }
        }
        
        return ErrorArray
    }

    
    static func parseSchedulePaymentTracker(story: NSArray) -> [PaymentTrackerRecordModel] {
        
        var ErrorArray = [PaymentTrackerRecordModel]()
        
        if let Items = story as Array? {
            
            for var index = 0; index < Items.count; ++index {
                
                if let Item = Items[index] as? NSDictionary {
                    
                    let temp = JSONParser.parseObjectSchedulePaymentTracker(Item as NSDictionary)
                    
                    ErrorArray.append(temp)
                }
            }
        }
        
        return ErrorArray
    }
    
    static func parseCoDebtorCode(story: NSArray) -> [String] {
        
        var CoDebtorCodeArray = [String]()
        
        if let Items = story as Array? {
            
            for var index = 0; index < Items.count; ++index {
                
                if let Item = Items[index] as? String {
                    
                    CoDebtorCodeArray.append(Item)
                }
            }
        }
        
        return CoDebtorCodeArray
    }
    
    static func parseObjectInboxItem(story: NSDictionary) -> InboxItem {
        
        let Object =  InboxItem()
        
        let tempDate = story["Date"] as? String ?? ""
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(tempDate)
        dateFormatter.dateFormat = "dd/MM/yyyy"
    
        
        Object.Date = dateFormatter.stringFromDate(date!)
        
        Object.MessageNo = Int32(story["MessageNo"] as? String ?? "0")!
        
        Object.Type = story["Type"] as? String ?? ""
        
        
        Object.Status = "Unread"
        
        Object.Content = story["MessagePathText"] as? String ?? ""

        return Object
    }

    
    static func parseObjectHistoryPaymentTracker(story: NSDictionary) -> PaymentTrackerRecordModel {
        
        let Object =  PaymentTrackerRecordModel()
        
        Object.DueDate = story["HistInstalDate"] as? String ?? ""
        
        Object.Amount = story["HistInstalAmount"] as? String ?? ""
        
        Object.Defer = story["HistDeferredAmount"] as? String ?? ""

        
        return Object
    }
    
    static func parseObjectSchedulePaymentTracker(story: NSDictionary) -> PaymentTrackerRecordModel {
        
        let Object =  PaymentTrackerRecordModel()
        
        Object.DueDate = story["InstalmentDate"] as? String ?? ""
        
        Object.Amount = story["InstalmentAmount"] as? String ?? ""
        
        return Object
    }
    
    static func parseClient(story: NSDictionary) -> Client {
        
        let client =  Client()
        
        client.ClientAcCode = story["ClientAcCode"] as? String ?? ""
        
        client.ClientCode = story["ClientCode"] as? String ?? ""
        
        client.FirstName = story["FirstName"] as? String ?? ""

        client.LastName = story["LastName"] as? String ?? ""
        
        client.BusinessName = story["BusinessName"] as? String ?? ""

        client.Email = story["Email"] as? String ?? ""
        
        client.Phone = story["Phone"] as? String ?? ""

        client.Mobile = story["Mobile"] as? String ?? ""
        
        client.ThreePartDateDurationDays = story["ThreePartDateDurationDays"] as? Int ?? 0

        client.ThreePartMaxDaysBetweenPayments = story["ThreePartMaxDaysBetweenPayments"] as? Int ?? 0
        
        client.IsAllowMonthlyInstallment = story["IsAllowMonthlyInstallment"] as? Bool ?? false

        return client
    }
    
//    static func parseLoginModel(story: NSDictionary) -> LoginModel {
//        
//        let object =  LoginModel()
//        
//        object.UserId = story["UserId"] as? Int ?? 0
//        
//        object.Username = story["Username"] as? String ?? ""
//        
//        object.FirstName = story["FirstName"] as? String ?? ""
//        
//        object.Phone = story["Phone"] as? String ?? ""
//        
//        object.LastName = story["LastName"] as? String ?? ""
//        
//        object.Email = story["Email"] as? String ?? ""
//        
//        object.Description = story["Description"] as? String ?? ""
//        
//        object.Password = story["Password"] as? String ?? ""
//
//        
//              
//        return object
//    }
//    
//    static func parseDirectory(story: NSDictionary) -> FolderModel {
//        
//        let object =  FolderModel()
//        
//        object.FolderName = story["FolderName"] as? String ?? ""
//        
//        var FileModelList = [FileModel]()
//        var FolderModelList = [FolderModel]()
//        
//        if let Items = (story["ChildFileList"] as? NSArray) as Array? {
//            
//            for var index = 0; index < Items.count; ++index {
//                if let Item = Items[index] as? NSDictionary {
//                    
//                    let temp = JSONParser.parseFileModel(Item as NSDictionary)
//                    
//                    FileModelList.insert(temp, atIndex: index)
//                }
//            }
//        }
//        
//        if let Items = (story["ChildFolderList"] as? NSArray) as Array? {
//            
//            FolderModelList = parseFolderModel(Items)
//        }
//        
//        object.childFiles = FileModelList
//        object.childFolders = FolderModelList
//        
//        
//        return object
//    }
//    
//    static func parseFolderModel(story: NSArray) -> [FolderModel] {
//        
//        var tempArray = [FolderModel]()
//        
//        if let Items = story as Array? {
//            
//            for var index = 0; index < Items.count; ++index {
//                
//                if let Item = Items[index] as? NSDictionary {
//                    
//                    let temp = JSONParser.parseDirectory(Item as NSDictionary)
//                    
//                    tempArray.append(temp)
//                }
//            }
//        }
//        
//        return tempArray
//    }
//
//    
//    
//    static func parseFileModel(story: NSDictionary) -> FileModel {
//        
//        
//        let Object =  FileModel()
//        
//        Object.FilePath =             story["FilePath"] as? String ?? ""
//        
//        Object.FileSize =             story["FileSize"] as? UInt64 ?? 0
//        
//        Object.FileName =             story["FileName"] as? String ?? ""
//        
//        Object.LocalFilePath =             story["LocalFilePath"] as? String ?? ""
//        
//        let dateFormatter = NSDateFormatter()
//        
//        dateFormatter.dateFormat = "yyyyMMdd HHmmss"
//        
//        dateFormatter.timeZone = NSTimeZone(name: "Australia/Melbourne")
//        
//        let date = dateFormatter.dateFromString(story["FileDate"] as? String ?? "")
//
//        
//        Object.FileDate = date
//        
//        return Object
//    }

    
    


}
