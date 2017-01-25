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
        
        tf_Pin0.addTarget(self, action: #selector(PinSetupViewController.tf_Pin0DidChange(_:)), for: UIControlEvents.editingChanged)
        
        InputFirstPin = true
        
        self.addDoneButtonOnKeyboard(tf_Pin0)

        // Do any additional setup after loading the view.
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PinSetupViewController.view_OnTop_Clicked(_:)))
        self.view1.addGestureRecognizer(gesture)
    }
    
    func view_OnTop_Clicked(_ sender:UITapGestureRecognizer){
        
        tf_Pin0.becomeFirstResponder()
    }
    
    func tf_Pin0DidChange(_ textField: UITextField) {
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
                
                WebApiService.sendActivityTracking("Setup Pin")

                self.performSegue(withIdentifier: "GoToLogin", sender: nil)

            }
            else
            {
                
                LocalStore.Alert(self.view, title: "Error", message: "PIN does not match - please try again", indexPath: 0)

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let  char = string.cString(using: String.Encoding.utf8)!
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
        
    }
    


}
