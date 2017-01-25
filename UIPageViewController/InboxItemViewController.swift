//
//  InboxItemViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 27/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit
import Alamofire

class InboxItemViewController: UIViewController, UIWebViewDelegate {

    
    var inboxDetail = InboxItem()
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var lb_Date: UILabel!
    
    @IBOutlet weak var tv_Content: UITextView!
    

    @IBOutlet weak var progressVIew1: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lb_Date.text = self.inboxDetail.Date
        
        self.progressVIew1.isHidden = true

        
        if(self.inboxDetail.ItemType == "T"){
            
            self.webView.isHidden = true
            
            self.tv_Content.text = self.inboxDetail.Content

            if(self.inboxDetail.Status == "Unread"){
                
                //Update Local Database
                self.inboxDetail.Status = "Read"
                
                ModelManager.getInstance().updateInboxItem(self.inboxDetail)
                
                //Send back status to RCS
                
                WebApiService.updateInboxItemMessage(LocalStore.accessRefNumber()!, MessageNo : self.inboxDetail.MessageNo.description, Action : "R") { objectReturn2 in
                    if let temp2 = objectReturn2
                    {
                        if(temp2.IsSuccess)
                        {
                            print("Read message successful")
                        }
                        else
                        {
                            LocalStore.Alert(self.view, title: "Error", message: temp2.Errors[0].ErrorMessage, indexPath: 0)
                            
                        }
                    }
                }
            }
            
            WebApiService.sendActivityTracking("Open Inbox Message")

        }
        else
            if(self.inboxDetail.ItemType == "D" || self.inboxDetail.ItemType == "R" || self.inboxDetail.ItemType == "P"){
                
                self.view.showLoading()
                
                self.tv_Content.isHidden = true
                
                if(inboxDetail.IsLocal)
                {
                    let fileName = self.inboxDetail.FileName
                    
                    let rootPath = NSTemporaryDirectory()
                    
                    let filePathReturn = (rootPath as NSString).appendingPathComponent(fileName)
                    
                    let url =  URL(fileURLWithPath: filePathReturn)
                    
                    let request = URLRequest(url: url)
                    
                    webView.loadRequest(request)
                    
                    self.webView.delegate = self
                    
                    self.view.hideLoading()
                }
                else
                {
                    
                    self.progressVIew1.isHidden = false
                    
                    WebApiService.getInboxItemDocument(LocalStore.accessRefNumber()!, DocumentPath: self.inboxDetail.Content) { objectReturn2 in
                        if let temp2 = objectReturn2
                        {
                            if(temp2.IsSuccess)
                            {
                                //We got the file that already download and save on server
                                //Get the fiel Path from server
                                let fromFilePath = temp2.Errors[0].ErrorMessage
                                
                                let rootPath = NSTemporaryDirectory()
                                
                                let currentTime = Int32(Date().timeIntervalSince1970)
                                
                                let filename = currentTime.description + ".pdf"
                                
                                let toFilePath = (rootPath as NSString).appendingPathComponent(filename)
                                
                                
                                //Download file into device with random name
                                self.getFile(fromFilePath, filePathReturn: toFilePath , fileName : filename)
                                
                               
                            }
                            else
                            {
                                LocalStore.Alert(self.view, title: "Error", message: temp2.Errors[0].ErrorMessage, indexPath: 0)
                                
                            }
                        }
                    }
                }
                    

                if(self.inboxDetail.Status == "Unread"){
                    
                    //Update Local Database
                    self.inboxDetail.Status = "Read"
                    
                    ModelManager.getInstance().updateInboxItem(self.inboxDetail)
                    
                    //Send back status to RCS
                    
                    WebApiService.updateInboxItemMessage(LocalStore.accessRefNumber()!, MessageNo : self.inboxDetail.MessageNo.description, Action : "R") { objectReturn2 in
                        if let temp2 = objectReturn2
                        {
                            if(temp2.IsSuccess)
                            {
                                print("Update message successful")
                            }
                            else
                            {
                                LocalStore.Alert(self.view, title: "Error", message: temp2.Errors[0].ErrorMessage, indexPath: 0)
                                
                            }
                        }
                    }
                    
                }
                
                WebApiService.sendActivityTracking("Open Inbox Document")

        }
    }
    
    func getFile(_ filePath : String , filePathReturn : String, fileName : String){
        
        //println(filePathReturn)
        
        
        let urlString = filePath
        
        
        let urlStr : NSString = urlString.addingPercentEscapes(using: String.Encoding.utf8)! as NSString
        
        var remoteUrl : NSURL? = NSURL(string: urlStr as String)
        
        let FileName = String((remoteUrl?.lastPathComponent)!) as NSString
        let pathExtension = FileName.pathExtension


//        let destination: (URL, HTTPURLResponse) -> (URL) = {
//            (temporaryURL, response) in
//            
//            
//            if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as? URL {
//                
//                let localImageURL = URL(fileURLWithPath: filePathReturn)
//
//                return localImageURL
//            }
//            
//            return temporaryURL
//        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            documentsURL.appendPathComponent((FileName as String) + "." + pathExtension)

            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(urlString, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility))
            {
                progress in
                print("Progress: \(progress.fractionCompleted)")
                
//                print("bytesRead : ", bytesRead)
//                print("totalBytesRead : ", totalBytesRead)
//                print("totalBytesExpectedToRead : ", totalBytesExpectedToRead)

                DispatchQueue.main.async( execute: {

                        self.progressVIew1.progress = Float(progress.fractionCompleted)
                        
                        if progress.completedUnitCount == progress.totalUnitCount {
                            
                            self.progressVIew1.isHidden = true
                        }
                })

            }
            .response { response in
                //insert into local database
                
                self.inboxDetail.IsLocal = true
                self.inboxDetail.Content = filePathReturn
                self.inboxDetail.FileName = fileName
                
                let results = ModelManager.getInstance().updateInboxItem(self.inboxDetail)
                
                if(results){
                    
                    let url =  NSURL(fileURLWithPath: filePathReturn)
                    
                    let request = NSURLRequest(url: url as URL)
                    
                    self.webView.loadRequest(request as URLRequest)
                    
                    self.webView.delegate = self
                    
                    self.view.hideLoading()

                }

        }
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteMessage(){
        
        self.view.showLoading()
        
        //Delete from local database
        ModelManager.getInstance().deleteInboxItem(self.inboxDetail)
        
        //Send to RCS
        WebApiService.updateInboxItemMessage(LocalStore.accessRefNumber()!, MessageNo : self.inboxDetail.MessageNo.description, Action : "D") { objectReturn2 in
            if let temp2 = objectReturn2
            {
                self.view.hideLoading()
                
                if(temp2.IsSuccess)
                {
                    
                    if(self.inboxDetail.ItemType == "D")
                    {
                        FolderManager.DeleteFile(self.inboxDetail.Content)
                    }
                    
                    print("Delete message successful")

                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    LocalStore.Alert(self.view, title: "Error", message: temp2.Errors[0].ErrorMessage, indexPath: 0)
                    
                }
            }
        }

    }
    
    @IBAction func deleteButton_Clicked(_ sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Are you sure to delete this message?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.deleteMessage()
        })
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
