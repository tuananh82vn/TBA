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
        
        //println(filePathReturn)
        
        
        let urlString = filePath
        
        
        let urlStr : NSString = urlString.addingPercentEscapes(using: String.Encoding.utf8)! as NSString
        
        var remoteUrl : NSURL? = NSURL(string: urlStr as String)
        
        let FileName = String((remoteUrl?.lastPathComponent)!) as NSString
        let pathExtension = FileName.pathExtension
        
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            documentsURL.appendPathComponent((FileName as String) + "." + pathExtension)
            
            return (documentsURL, [.removePreviousFile])
        }
        
        
        Alamofire.download(urlStr.description, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility))
            {
                progress in
                print("Progress: \(progress.fractionCompleted)")
                
            }
            .response { response in
                
        }
    }
}
