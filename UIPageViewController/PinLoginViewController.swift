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
    
    
    @IBOutlet weak var view_OnTop: UIView!
    
    var pageIndex : Int = 1
    var position : Int = 1;
    
    var FinishFirstPin : Bool = false;

    var InputFirstPin : Bool = false;

    var FirstPin : String = "";
    
    var numberOfIncorrect = 0;
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard(tf_Pin0)
        
        
        //hide back button
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: false) //or animated: false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        

        
        InputFirstPin = true

        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PinLoginViewController.view_OnTop_Clicked(_:)))
        self.view_OnTop.addGestureRecognizer(gesture)

        
        tf_Pin0.delegate = self;
        
        tf_Pin0.addTarget(self, action: #selector(PinLoginViewController.tf_Pin0DidChange(_:)), for: UIControlEvents.editingChanged)
        tf_Pin0.becomeFirstResponder()

        
//        //Handle auto hide keyboard
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
        

    }
    
    func view_OnTop_Clicked(_ sender:UITapGestureRecognizer){
        
        self.resetText()
        
        tf_Pin0.becomeFirstResponder()
    }
    
    override var prefersStatusBarHidden : Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }
    
//    //Calls this function when the tap is recognized.
//    func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    @IBAction func btForgotten_Clicked(_ sender: AnyObject) {
        
        view.endEditing(true)

        let alert = SCLAlertView()
        alert.hideWhenBackgroundViewIsTapped = true
        alert.showCloseButton = false
        
        alert.addButton("Yes"){
            self.resetDevice()
        }
        alert.addButton("No") {
            self.tf_Pin0.becomeFirstResponder()
        }
        alert.showWarning("", subTitle: "Recoveriesconnect will be reset - you will need to verify and set up again. Continue?")
        
        
    }
    
    func resetDevice(){
        
        //Delete Local Database
        ModelManager.getInstance().deleteAllInboxItem()
        
        //Reset Setting
        LocalStore.setPin("")
        LocalStore.setDRCode("")
        LocalStore.setMaxNoPay(0)
        LocalStore.setTotalPaid("")
        LocalStore.setIsPinSetup(false)
        LocalStore.setTotalOverDue("")
        LocalStore.setWeeklyAmount(0)
        LocalStore.setMonthlyAmount(0)
        
        LocalStore.setFortnightAmount(0)
        LocalStore.setTotalOutstanding(0)
        LocalStore.setIsExistingArrangement(false)
        
        LocalStore.setIsCoBorrowersSelected(false)
        LocalStore.setIsArrangementUnderThisDebtor(false)
        LocalStore.setRefNumber("")
        
        LocalStore.setDebtorCodeSelected("")
        LocalStore.setIsCoBorrowers(false)
        
        LocalStore.setArrangementDebtor("")
        LocalStore.setThreePartDateDurationDays(0)
        LocalStore.setIsAllowMonthlyInstallment(false)
        
        LocalStore.setIsExistingArrangementDD(false)
        LocalStore.setIsExistingArrangementCC(false)
        LocalStore.setFirstAmountOfInstalment(0)
        
        LocalStore.setNextPaymentInstallment(0)
        LocalStore.setMakePaymentOtherAmount(false)
        LocalStore.setMakePaymentInstallment(false)
        LocalStore.setMakePaymentIn3Part(false)
        LocalStore.setMakePaymentInFull(false)
    
        LocalStore.setIsAgreePrivacy(false)

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        
        self.present(vc, animated: true, completion: nil)

    }
    
    func tf_Pin0DidChange(_ textField: UITextField) {
        if(InputFirstPin && FinishFirstPin){
            
            self.FirstPin = tf_Pin0.text!
            
            if(self.FirstPin == LocalStore.accessPin()!){

                if(LocalStore.accessIsAgreePrivacy()){
                    self.performSegue(withIdentifier: "GoToLogin", sender: nil)
                }
                else
                {
                    self.performSegue(withIdentifier: "GoToPrivacy", sender: nil)
                }
                
            }
            else
            {
                
                numberOfIncorrect  = numberOfIncorrect + 1
                if(numberOfIncorrect == 10)
                {
                    LocalStore.Alert(self.view, title: "Error", message: "10 failed PIN attempts - recoveriesconnect has been reset", indexPath: 0)

                    self.resetDevice()
                }
                else
                {
                    LocalStore.Alert(self.view, title: "Error", message: "Entered PIN is incorrect - please try again", indexPath: 0)
                
                    self.resetText()
                }
            }
            
        }

    }
    
    func resetText(){
        
        
        tf_Pin0.text = ""
        
        tf_Pin4.text = ""
        
        tf_Pin3.text = ""
        
        tf_Pin2.text = ""
        
        tf_Pin1.text = ""
        
        position = 1
        
        FinishFirstPin  = false
        
        InputFirstPin  = true
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
