//
//  DownloadFile.swift
//  UIPageViewController
//
//  Created by andy synotive on 29/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit
import Alamofire


struct DownloadFile {
    
    static func getFile(filePath : String , filePathReturn : String){
        
        //println(filePathReturn)
        
        
        let urlString = filePath
        
        
        let urlStr : NSString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        //var remoteUrl : NSURL? = NSURL(string: urlStr as String)
        
        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
            (temporaryURL, response) in
            
            
            if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
                
                let localImageURL = NSURL(fileURLWithPath: filePathReturn)
                
                return localImageURL
            }
            
            return temporaryURL
        }
        
        Alamofire.download(.GET, urlStr.description, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                
                print("bytesRead : ", bytesRead)
                print("totalBytesRead : ", totalBytesRead)
                print("totalBytesExpectedToRead : ", totalBytesExpectedToRead)
                
                //This closure is NOT called on the main queue for performance
                //reasons. To update your ui, dispatch to the main queue.
                dispatch_async(dispatch_get_main_queue()) {
                    
                    print("bytes Download : ", bytesRead)

                    if totalBytesRead == totalBytesExpectedToRead {
                         print("Download Done")
                    }
                }
            }
            .response { response in

        }
        
    }
}