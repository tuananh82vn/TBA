//
//  PinSetupViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 4/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PinSetupViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tf_Pin0: UITextField!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var tf_Pin4: UITextField!
    @IBOutlet weak var tf_Pin3: UITextField!
    @IBOutlet weak var tf_Pin2: UITextField!
    @IBOutlet weak var tf_Pin1: UITextField!
    
    var position : Int = 1;
    
    var FinishFirstPin : Bool = false;
    var FinishSecondPin : Bool = false;
    
    var InputFirstPin : Bool = false;
    var InputSecondPin : Bool = false;

    
    var FirstPin : String = "";
    
    var SecondPin : String = "";
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tf_Pin0.becomeFirstResponder()
        
        tf_Pin0.delegate = self;
        
        tf_Pin0.addTarget(self, action: "tf_Pin0DidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        InputFirstPin = true
        
        self.addDoneButtonOnKeyboard(tf_Pin0)

        // Do any additional setup after loading the view.
    }
    
    func tf_Pin0DidChange(textField: UITextField) {
        if(InputFirstPin && FinishFirstPin){
            
            self.FirstPin = tf_Pin0.text!
            
            tf_Pin0.text = ""
            
            tf_Pin4.text = ""
            
            tf_Pin3.text = ""
            
            tf_Pin2.text = ""
                    
            tf_Pin1.text = ""
            
            position = 1
            
            lable1.text = "Re-enter the PIN";
            
            if(FinishFirstPin)
            {
                InputFirstPin = false
                InputSecondPin = true
                
            }
            
        }
        
        if(InputSecondPin && FinishSecondPin){
            
            self.SecondPin = tf_Pin0.text!
            
            if(self.FirstPin == self.SecondPin){
                
                
                //Save Pin
                LocalStore.setPin(self.FirstPin)
                
                LocalStore.setIsPinSetup(true)
                
                self.performSegueWithIdentifier("GoToLogin", sender: nil)

            }
            else
            {
//                let alert = SCLAlertView()
//                alert.hideWhenBackgroundViewIsTapped = true
//                alert.showError("Error", subTitle:"Pin not match - try again.")
                
                LocalStore.Alert(self.view, title: "Error", message: "Pin not match - try again.", indexPath: 0)

                
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
        FinishSecondPin = false
        
        InputFirstPin  = true
        InputSecondPin = false
        
        lable1.text = "Enter the PIN you will use to access this app";


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
                
                if(InputSecondPin){
                    self.FinishSecondPin = true
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
        
    }
    


}
