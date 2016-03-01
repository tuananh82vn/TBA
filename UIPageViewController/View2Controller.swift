//
//  View2Controller.swift
//  UIPageViewController
//
//  Created by synotivemac on 7/09/2015.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class View2Controller: BaseViewController {

    
    @IBOutlet weak var tf_Netcode: UITextField!
    @IBOutlet weak var tf_DebtCode: UITextField!
    var pageIndex : Int = 1
    
    @IBOutlet weak var bt_Continue: UIButton!
    @IBOutlet weak var bt_GetNetCode: UIButton!
    
    @IBOutlet weak var lb_netcode: UILabel!
    var debtorList = [CoDebtor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tf_DebtCode.text = ""
        
        // Show button get net code
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_GetNetCode.alpha = 1
        })
        
        //Handle auto hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Hide button cotinue.
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_Continue.alpha = 0
            self.bt_Continue.enabled = false
            self.tf_Netcode.enabled = false
            self.tf_Netcode.alpha = 0
            
            self.lb_netcode.alpha = 0
            
        })
        
        self.addDoneButtonOnKeyboard(tf_DebtCode)
        self.addDoneButtonOnKeyboard(tf_Netcode)

    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("someSelector"), userInfo: nil, repeats: false)
    }
    
    func someSelector() {
        self.tf_DebtCode.becomeFirstResponder()
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GetNetCodeClicked(sender: AnyObject) {

        if(self.tf_DebtCode.text!.length > 9 || self.tf_DebtCode.text!.length < 9)
        {
            let alert = SCLAlertView()
            alert.hideWhenBackgroundViewIsTapped = true
            alert.showError("Error", subTitle:"Please enter correct reference number")
        }
        else
        {
            doGetNetCode()
        }
    }
    
    @IBAction func ContinueClicked(sender: AnyObject) {

        self.view.showLoading();
        
        
        WebApiService.verifyNetCode(self.tf_DebtCode.text!, Netcode: self.tf_Netcode.text!) { objectReturn in

            if let temp1 = objectReturn
            {
                self.view.hideLoading();

                if(temp1.IsSuccess)
                {
                    LocalStore.setRefNumber(self.tf_DebtCode.text!)
                    
                    self.performSegueWithIdentifier("GoToSetupPin", sender: nil)
                }
                else
                {
                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showError("Error", subTitle:"Invalid Netcode")

                    self.bt_GetNetCode.enabled = true
                    //
                    self.bt_GetNetCode.backgroundColor = UIColor.init(hex: "#30a742")
                }
                
            }
        }
            
    
 

    }
    
    func doGetNetCode(){
        
        self.view.showLoading();
        
        WebApiService.checkInternet({(internet:Bool) -> Void in
            
                if (internet)
                {
                    
                    //check Is Co-Borrower
                    WebApiService.GetDebtorInfo(self.tf_DebtCode.text!) { objectReturn in
                        
                        if let temp1 = objectReturn
                        {
                            if(temp1.IsSuccess)
                            {
                                self.debtorList = temp1.coDebtor
                                LocalStore.setIsCoBorrowers(temp1.IsCoBorrowers)
                                LocalStore.setArrangementDebtor(temp1.ArrangementDebtor)
                                LocalStore.setIsArrangementUnderThisDebtor(true)
    
                                if(LocalStore.accessIsCoBorrowers()!){
                                    
                                    
                                    LocalStore.setRefNumber(self.tf_DebtCode.text!)
                                    
                                    self.performSegueWithIdentifier("GoToDebtorSelect", sender: nil)
                                    
                                }
                                else
                                {
                                    
                                    //Get net code
                                    WebApiService.getNetCode(self.tf_DebtCode.text!){ objectReturn in
                                        
                                        self.view.hideLoading();
                                        
                                        if let temp1 = objectReturn
                                        {
                                            
                                            if(temp1.IsSuccess)
                                            {
                                                
                                                let alert = SCLAlertView()
                                                alert.hideWhenBackgroundViewIsTapped = true
                                                alert.showNotice("", subTitle:temp1.Errors[0].ErrorMessage)
                                                
                                                //Enable net code
                                                self.tf_Netcode.enabled = true
                                                self.tf_Netcode.alpha = 1
                                                
                                                self.lb_netcode.alpha = 1
                                                
                                                self.bt_GetNetCode.setTitle("Get your NetCode again ?", forState: UIControlState.Normal)
                                                
                                                //Enable button continue
                                                self.bt_Continue.enabled = true
                                                self.bt_Continue.alpha = 1
                                                
                                                
                                                self.tf_Netcode.becomeFirstResponder()
                                                
                                                
                                            }
                                            else
                                            {
                                                let alert = SCLAlertView()
                                                alert.hideWhenBackgroundViewIsTapped = true
                                                alert.showError("Error", subTitle:temp1.Errors[0].ErrorMessage)
                                                
                                            }
                                            
                                            
                                            
                                        }
                                        else
                                        {
                                            let alert = SCLAlertView()
                                            alert.hideWhenBackgroundViewIsTapped = true
                                            alert.showError("Error", subTitle:"Server not found.")
                                        }
                                    }
                                
                                }
                                
                                
                            }
                        }
                    }
                }
                else
                {
                    
                    self.view.hideLoading();
                    
                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showWarning("Error", subTitle:"No connections are available.")
                    
                }
        })
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToDebtorSelect" {
            
            let controller = segue.destinationViewController as! SelectDebtorController
            controller.debtorList = self.debtorList
        }
    }
    



}
