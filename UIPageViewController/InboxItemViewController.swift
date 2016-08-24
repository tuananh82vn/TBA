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
        
        self.progressVIew1.hidden = true

        
        if(self.inboxDetail.Type == "T"){
            
            self.webView.hidden = true
            
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
        }
        else
            if(self.inboxDetail.Type == "D"){
                
                self.view.showLoading()
                
                self.tv_Content.hidden = true
                
                if(inboxDetail.IsLocal)
                {
                    let fileName = self.inboxDetail.FileName
                    
                    let rootPath = NSTemporaryDirectory()
                    
                    let filePathReturn = (rootPath as NSString).stringByAppendingPathComponent(fileName)
                    
                    let url =  NSURL(fileURLWithPath: filePathReturn)
                    
                    let request = NSURLRequest(URL: url)
                    
                    webView.loadRequest(request)
                    
                    self.webView.delegate = self
                    
                    self.view.hideLoading()
                }
                else
                {
                    
                    self.progressVIew1.hidden = false
                    
                    WebApiService.getInboxItemDocument(LocalStore.accessRefNumber()!, DocumentPath: self.inboxDetail.Content) { objectReturn2 in
                        if let temp2 = objectReturn2
                        {
                            if(temp2.IsSuccess)
                            {
                                //We got the file that already download and save on server
                                //Get the fiel Path from server
                                let fromFilePath = temp2.Errors[0].ErrorMessage
                                
                                let rootPath = NSTemporaryDirectory()
                                
                                let currentTime = Int32(NSDate().timeIntervalSince1970)
                                
                                let filename = currentTime.description + ".pdf"
                                
                                let toFilePath = (rootPath as NSString).stringByAppendingPathComponent(filename)
                                
                                
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


        }
    }
    
    func getFile(filePath : String , filePathReturn : String, fileName : String){
        
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

                dispatch_async(dispatch_get_main_queue()) {

                    
                    let progress = Float(totalBytesRead) / Float(totalBytesExpectedToRead)
                    
                    self.progressVIew1.progress = progress
                    
                    if totalBytesRead == totalBytesExpectedToRead {
                        
                        self.progressVIew1.hidden = true
                    }
                }

            }
            .response { response in
                //insert into local database
                
                self.inboxDetail.IsLocal = true
                self.inboxDetail.Content = filePathReturn
                self.inboxDetail.FileName = fileName
                
                let results = ModelManager.getInstance().updateInboxItem(self.inboxDetail)
                
                if(results){
                    
                    let url =  NSURL(fileURLWithPath: filePathReturn)
                    
                    let request = NSURLRequest(URL: url)
                    
                    self.webView.loadRequest(request)
                    
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
                    
                    if(self.inboxDetail.Type == "D")
                    {
                        FolderManager.DeleteFile(self.inboxDetail.Content)
                    }
                    
                    print("Delete message successful")

                    self.navigationController?.popViewControllerAnimated(true)
                }
                else
                {
                    LocalStore.Alert(self.view, title: "Error", message: temp2.Errors[0].ErrorMessage, indexPath: 0)
                    
                }
            }
        }

    }
    
    @IBAction func deleteButton_Clicked(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Are you sure to delete this message?", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.deleteMessage()
        })
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
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
