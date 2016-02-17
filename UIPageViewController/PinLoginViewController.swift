//
//  PinSetupViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 4/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PinLoginViewController: BaseViewController, UITextFieldDelegate , TKAlertDelegate{
    

    @IBOutlet weak var tf_Pin0: UITextField!
    @IBOutlet weak var tf_Pin4: UITextField!
    @IBOutlet weak var tf_Pin3: UITextField!
    @IBOutlet weak var tf_Pin2: UITextField!
    @IBOutlet weak var tf_Pin1: UITextField!
    
    
    var pageIndex : Int = 1
    var position : Int = 1;
    
    var FinishFirstPin : Bool = false;

    var InputFirstPin : Bool = false;

    var FirstPin : String = "";
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false) //or animated: false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        tf_Pin0.delegate = self;
        
        tf_Pin0.addTarget(self, action: "tf_Pin0DidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        InputFirstPin = true
        
        tf_Pin0.becomeFirstResponder()
        
//        //Handle auto hide keyboard
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Fade
    }
    
//    //Calls this function when the tap is recognized.
//    func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    @IBAction func btForgotten_Clicked(sender: AnyObject) {
                
        

            
        
        let optionMenu = UIAlertController(title: nil, message: "The app will be reseted , you will need to setup and verify it again. Continue ?", preferredStyle: .Alert)
        
        let logoutAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            //Reset Setting
            LocalStore.setIsPinSetup(false);
            LocalStore.setIsCoBorrowersSelected(false)
            LocalStore.setPin("")
            LocalStore.setRefNumber("")
            LocalStore.setIsArrangementUnderThisDebtor(false)
            LocalStore.setDebtorCodeSelected("")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            self.presentViewController(vc, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in

            self.tf_Pin0.becomeFirstResponder()

        })
        
        
        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)

        
        
    }
    

    
    func tf_Pin0DidChange(textField: UITextField) {
        if(InputFirstPin && FinishFirstPin){
            
            self.FirstPin = tf_Pin0.text!
            
            if(self.FirstPin == LocalStore.accessPin()!){

                self.performSegueWithIdentifier("GoToLogin", sender: nil)
                
            }
            else
            {
                
                // create the alert
                let alert = UIAlertController(title: "Incorrect PIN", message: "Your PIN is incorrect. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                
                reset()
            }
            
        }

    }
    
    func reset(){
        
        
        tf_Pin0.text = ""
        
        tf_Pin4.text = ""
        
        tf_Pin3.text = ""
        
        tf_Pin2.text = ""
        
        tf_Pin1.text = ""
        
        position = 1
        
        FinishFirstPin  = false
        InputFirstPin  = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cStringUsingEncoding(NSUTF8StringEncoding)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            
            if(position > 1){
                position = position - 1
            }
            
            if(position == 4)
            {
                tf_Pin4.text = ""
            }
            
            if(position == 3)
            {
                tf_Pin4.text = ""
                tf_Pin3.text = ""
            }
            
            if(position == 2)
            {
                tf_Pin4.text = ""
                tf_Pin3.text = ""
                tf_Pin2.text = ""
            }
            
            if(position == 1)
            {
                tf_Pin1.text = ""
                tf_Pin2.text = ""
                tf_Pin3.text = ""
                tf_Pin4.text = ""
            }
            
            
        }
        else
        {
            if(position == 1)
            {
                tf_Pin1.text = "*"
            }
            
            if(position == 2)
            {
                tf_Pin1.text = "*"
                tf_Pin2.text = "*"
            }
            
            if(position == 3)
            {
                tf_Pin1.text = "*"
                tf_Pin2.text = "*"
                tf_Pin3.text = "*"
            }
            
            if(position == 4)
            {
                tf_Pin1.text = "*"
                tf_Pin2.text = "*"
                tf_Pin3.text = "*"
                tf_Pin4.text = "*"
            }
            
            if(position < 4){
                position = position + 1
            }
            else
            {
                if(InputFirstPin){
                    self.FinishFirstPin = true
                }
                
            }
            
            
        }
        
        if (textField.text!.length >= 4 && range.length == 0)
        {
            return false; // return NO to not change text
        }
        else
        {
            return true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
