//
//  SendFeedbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 15/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class SendFeedbackViewController: UIViewController , UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet weak var tf_Subject: UITextField!
    @IBOutlet weak var tf_Content: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf_Subject.delegate = self //set delegate to textfile
        tf_Content.delegate = self //set delegate to textfile
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        
        let toolbar = UIToolbar()
        toolbar.bounds = CGRectMake(0, 0, 320, 50)
        toolbar.sizeToFit()
        toolbar.barStyle = UIBarStyle.Default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "handleDone:")
        ]
        
        self.tf_Content.inputAccessoryView = toolbar
    }
    
    func handleDone(sender:UIButton) {
        self.tf_Content.resignFirstResponder()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        
        if (textField.returnKeyType == UIReturnKeyType.Next)
        {
            tf_Content.becomeFirstResponder()
        }
        
        return true
    }

    
    func DoSend(){
        
        self.view.showLoading();
        
        var objectInfo = Feedback()
        
        objectInfo.Subject      = self.tf_Subject.text!
        objectInfo.Content      = self.tf_Content.text

        WebApiService.SendFeedback(objectInfo){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                    self.performSegueWithIdentifier("GoToNotice", sender: nil)
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: temp1.Errors[0].ErrorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }

    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        self.DoSend()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your feedback has been sent successfully."
            
        }
    }

}
