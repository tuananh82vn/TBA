//
//  InboxItemViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 27/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit

class InboxItemViewController: UIViewController {

    
    var inboxDetail = InboxItem()
    
    @IBOutlet weak var lb_Date: UILabel!
    
    @IBOutlet weak var tv_Content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lb_Date.text = self.inboxDetail.Date
        
        
        if(self.inboxDetail.Type == "T"){
            
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
        else
            if(self.inboxDetail.Type == "D"){
                
                
                WebApiService.getInboxItemDocument(LocalStore.accessRefNumber()!, DocumentPath: self.inboxDetail.Content) { objectReturn2 in
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteButton_Clicked(sender: AnyObject) {
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
