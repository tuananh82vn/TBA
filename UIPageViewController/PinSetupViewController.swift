//
//  PinSetupViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 4/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PinSetupViewController: UIViewController, UITextFieldDelegate {

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

        // Do any additional setup after loading the view.
    }
    
    func tf_Pin0DidChange(textField: UITextField) {
        if(InputFirstPin && FinishFirstPin){
            
            NSLog(tf_Pin0.text!)
            
            self.FirstPin = tf_Pin0.text!
            
            tf_Pin0.text = ""
            
            tf_Pin4.text = ""
            
            tf_Pin3.text = ""
            
            tf_Pin2.text = ""
                    
            tf_Pin1.text = ""
            
            position = 1
            
            lable1.text = "Re-enter the PIN you will use to access this app";
            
            if(FinishFirstPin)
            {
                InputFirstPin = false
                InputSecondPin = true
                
            }
        }
        
        if(InputSecondPin && FinishSecondPin){
            
            self.SecondPin = tf_Pin0.text!
            
            if(self.FirstPin == self.SecondPin){
                NSLog("Pin match")
                
                self.performSegueWithIdentifier("GoToLogin", sender: nil)

            }
            else
            {
                NSLog("Pin not match - input again")
                
                let customIcon = UIImage(named: "no-internet")
                let alertview = JSSAlertView().show(self, title: "Warning", text: "Pin not match - input again", buttonText: "Try later", color: UIColorFromHex(0xe74c3c, alpha: 1), iconImage: customIcon)
                alertview.setTextTheme(.Light)
                
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
            NSLog("backspace tapped ");
            
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

            if(position > 1){
                position = position - 1
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
        
        NSLog(position.description)
        
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
