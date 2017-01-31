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
    
    static func getFile(_ filePath : String , filePathReturn : String){
        
        
        let urlStr : NSString = filePath.addingPercentEscapes(using: String.Encoding.utf8)! as NSString

        let remoteUrl : NSURL? = NSURL(string: filePathReturn as String)
        
        let FileName = String((remoteUrl?.lastPathComponent)!) as NSString
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            documentsURL.appendPathComponent((FileName as String))
            
            return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        
        Alamofire.download(urlStr.description, method: .get, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility))
            {
                progress in
                print("Progress: \(progress.completedUnitCount)")
                
            }
            .response { response in
                
                print(response.request)
                print(response.response)
                print(response.temporaryURL)
                print(response.destinationURL)
                print(response.error)
                
//                let fileExists = FileManager().fileExists(atPath: filePathReturn)

        }
    }
}
