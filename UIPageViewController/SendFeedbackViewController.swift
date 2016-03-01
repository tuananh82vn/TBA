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
        
        
//        let toolbar = UIToolbar()
//        toolbar.bounds = CGRectMake(0, 0, 320, 50)
//        toolbar.sizeToFit()
//        toolbar.barStyle = UIBarStyle.Default
//        toolbar.items = [
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: "handleDone:")
//        ]
//        
//        self.tf_Subject.inputAccessoryView = toolbar
//
//        self.tf_Content.inputAccessoryView = toolbar
        
        self.addDoneButtonOnKeyboard(tf_Subject)
        self.addDoneButtonOnKeyboard(tf_Content)
        
        tf_Subject.becomeFirstResponder()
    }
    
//    func handleDone(sender:UIButton) {
//        self.tf_Content.resignFirstResponder()
//    }
    
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
                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showError("Error", subTitle:temp1.Errors[0].ErrorMessage)

                }
            }
            else
            {
                // create the alert
                let alert = SCLAlertView()
                alert.hideWhenBackgroundViewIsTapped = true
                alert.showError("Error", subTitle:"Server not found.")
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
    
    func addDoneButtonOnKeyboard(view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        doneToolbar.translucent = false
        doneToolbar.barTintColor = UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: view, action: "resignFirstResponder")
        
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        
        
        doneToolbar.sizeToFit()
        
        if let accessorizedView = view as? UITextField {
            accessorizedView.inputAccessoryView = doneToolbar
        }
        
        if let accessorizedView = view as? UITextView {
            accessorizedView.inputAccessoryView = doneToolbar
        }
        
    }

}
