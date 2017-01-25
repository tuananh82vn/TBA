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
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.bt_GetNetCode.alpha = 1
        })
        
        //Handle auto hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(View2Controller.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Hide button cotinue.
        //UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_Continue.alpha = 0
            self.bt_Continue.isEnabled = false
            self.tf_Netcode.isEnabled = false
            self.tf_Netcode.alpha = 0
            
            self.lb_netcode.alpha = 0
        
            self.tf_Netcode.maxLength = 6;
        
        //})
        
        self.addSendButtonOnKeyboard(tf_DebtCode)
        self.addContinueButtonOnKeyboard(tf_Netcode)

    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        var timer = Foundation.Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(View2Controller.someSelector), userInfo: nil, repeats: false)
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
    
    @IBAction func GetNetCodeClicked(_ sender: AnyObject) {

        if(self.tf_DebtCode.text!.length > 9 || self.tf_DebtCode.text!.length < 9)
        {
            
            LocalStore.Alert(self.view, title: "Error", message: "Please enter correct reference number", indexPath: 0)

        }
        else
        {
            doGetNetCode()
        }
    }
    
    @IBAction func ContinueClicked(_ sender: AnyObject) {

        Continue()
    }
    
    func Continue()
    {
        self.view.showLoading();
        
        if(self.tf_Netcode.text?.length != 6 ){
            
            self.view.hideLoading();
            
            LocalStore.Alert(self.view, title: "Error", message: "Invalid NetCode", indexPath: 0)
        }
        else
        {
            
            WebApiService.verifyNetCode(self.tf_DebtCode.text!, Netcode: self.tf_Netcode.text!) { objectReturn in
                
                if let temp1 = objectReturn
                {
                    self.view.hideLoading();
                    
                    if(temp1.IsSuccess)
                    {
                        LocalStore.setRefNumber(self.tf_DebtCode.text!)
                        
                        self.performSegue(withIdentifier: "GoToSetupPin", sender: nil)
                    }
                    else
                    {
                        
                        LocalStore.Alert(self.view, title: "Error", message: "Invalid NetCode", indexPath: 0)
                        
                        
                        self.bt_GetNetCode.isEnabled = true
                        //
                        self.bt_GetNetCode.backgroundColor = UIColor.init(hex: "#30a742")
                    }
                    
                }
            }
        }

    }
    
    
    func doGetNetCode(){
        
        self.view.showLoading();
        
//        WebApiService.checkInternet({(internet:Bool) -> Void in
//            
//                if (internet)
//                {
        
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
                                    self.performSegue(withIdentifier: "GoToDebtorSelect", sender: nil)
                                }
                                else
                                {
                                    //Get net code
                                    WebApiService.getNetCode(ReferenceNumber: self.tf_DebtCode.text!){ objectReturn in
                                        self.view.hideLoading();
                                        if let temp1 = objectReturn
                                        {
                                            if(temp1.IsSuccess)
                                            {
                                                
                                                if(temp1.Errors.count > 0){
                                                    LocalStore.Alert(self.view, title: "Notice", message: temp1.Errors[0].ErrorMessage, indexPath: 3)
                                                }
                                                else
                                                {
                                                    LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                                                }
                                                

                                                //Enable net code
                                                self.tf_Netcode.isEnabled = true
                                                self.tf_Netcode.alpha = 1
                                                self.lb_netcode.alpha = 1
                                                self.bt_GetNetCode.setTitle("Get your NetCode again?", for: UIControlState())
                                                //Enable button continue
                                                self.bt_Continue.isEnabled = true
                                                self.bt_Continue.alpha = 1
                                                self.tf_Netcode.becomeFirstResponder()
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
                            else
                            {
                                self.view.hideLoading();
                                
                                if(temp1.Errors.count > 0){
                                    LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                                }
                                else
                                {
                                    LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                                }

                            }
                        }
                    }
//                }
//                else
//                {
//                    
//                    self.view.hideLoading();
//                    
//                    LocalStore.Alert(self.view, title: "Error", message: "No connections are available.", indexPath: 0)
//
//                    
//                }
//        })
    }
    
    func addSendButtonOnKeyboard(_ view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = false
        doneToolbar.barTintColor = UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.ButtonSendTapped(sender:)))
        
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        
        
        doneToolbar.sizeToFit()
        
        if let accessorizedView = view as? UITextField {
            accessorizedView.inputAccessoryView = doneToolbar
        }
        
    }
    
    func addContinueButtonOnKeyboard(_ view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = false
        doneToolbar.barTintColor = UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Continue", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.ButtonContinueTapped(sender:)))
        
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        
        
        doneToolbar.sizeToFit()
        
        if let accessorizedView = view as? UITextField {
            accessorizedView.inputAccessoryView = doneToolbar
        }
        
    }

    func ButtonSendTapped(sender: UIBarButtonItem) {
        
        doGetNetCode()
        
        self.view.endEditing(true)
    }
    
    func ButtonContinueTapped(sender: UIBarButtonItem) {
        
        Continue()
        
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDebtorSelect" {
            
            let controller = segue.destination as! SelectDebtorController
            controller.debtorList = self.debtorList
        }
    }
    



}
