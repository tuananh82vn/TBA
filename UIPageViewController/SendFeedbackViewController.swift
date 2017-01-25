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
    
    var isValidate : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf_Subject.delegate = self //set delegate to textfile
        tf_Content.delegate = self //set delegate to textfile
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SendFeedbackViewController.dismissKeyboard))
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
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        if (textField.returnKeyType == UIReturnKeyType.next)
        {
            tf_Content.becomeFirstResponder()
        }

        return true
    }

    func checkValidate()
    {
        isValidate = true

        if(self.tf_Subject.text?.length == 0)
        {
            LocalStore.Alert(self.view, title: "Error", message: "Please enter subject", indexPath: 0)
            tf_Subject.becomeFirstResponder()
            isValidate = false
        }
        else
            if(self.tf_Content.text?.length == 0)
            {
                LocalStore.Alert(self.view, title: "Error", message: "Please enter content", indexPath: 0)
                tf_Content.becomeFirstResponder()
                isValidate = false
        }
        
    }

    func DoSend(){
        
        checkValidate()
        
        if(self.isValidate){
        
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
                        WebApiService.sendActivityTracking("Send Feedback")

                        self.performSegue(withIdentifier: "GoToNotice", sender: nil)
                    }
                    else
                    {
                        
                        if(temp1.Errors.count > 0){
                            LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                        }
                        else
                        {
                            LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                        }
                    }
                }
                else
                {
                    
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                    
                }
            }
        }

    }

    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        self.DoSend()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "Your feedback has been sent successfully"
            
        }
    }
    
    func addDoneButtonOnKeyboard(_ view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = false
        doneToolbar.barTintColor = UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: view, action: #selector(UIResponder.resignFirstResponder))
        
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
