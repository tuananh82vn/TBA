//
//  VerifyCoDebtorViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 16/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit

class VerifyCoDebtorViewController: UIViewController {

    var selectedDebtor = CoDebtor()
    
    @IBOutlet weak var lb_netcode: UILabel!
    @IBOutlet weak var bt_Continue: UIButton!
    @IBOutlet weak var tf_NetCode: UITextField!
    @IBOutlet weak var btGetNetCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show button get net code
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.btGetNetCode.alpha = 1
        })
        
        //Handle auto hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Hide button cotinue.
        //UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_Continue.alpha = 0
            self.bt_Continue.enabled = false
        
        
            self.tf_NetCode.alpha = 0
            self.tf_NetCode.enabled = false
        
            self.lb_netcode.alpha = 0
            self.lb_netcode.enabled = false
        //})
        
        self.addDoneButtonOnKeyboard(self.tf_NetCode)
        

        // Do any additional setup after loading the view.
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
    
    @IBAction func btNetCode_Clicked(sender: AnyObject) {
        
        doGetNetCode()

    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        self.view.showLoading();
        
        WebApiService.verifyNetCode(LocalStore.accessRefNumber()!, Netcode: self.tf_NetCode.text!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                self.view.hideLoading();
                
                if(temp1.IsSuccess)
                {
                    LocalStore.setIsCoBorrowersSelected(true)
                    
                    LocalStore.setDebtorCodeSelected(self.selectedDebtor.DebtorCode)
                    
                    if(self.selectedDebtor.DebtorCode == LocalStore.accessArrangementDebtor())
                    {
                        LocalStore.setIsArrangementUnderThisDebtor(true)
                    }
                    else
                    {
                        LocalStore.setIsArrangementUnderThisDebtor(false)

                    }
                    
                    LocalStore.setDRCode(self.selectedDebtor.DebtorCode)

                    self.performSegueWithIdentifier("GoToSetupPin", sender: nil)
                }
                else
                {

                    LocalStore.Alert(self.view, title: "Error", message: "NetCode is not valid", indexPath: 0)

                }
                
            }
        }

    }
    
    func doGetNetCode(){
        
        self.view.showLoading();
        
        WebApiService.checkInternet({(internet:Bool) -> Void in
            
            if (internet)
            {
                
                WebApiService.getNetCodeVerify(LocalStore.accessRefNumber()!, MobileNumber : self.selectedDebtor.Mobile ){ objectReturn in
                    
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
                            

                            self.btGetNetCode.setTitle("Get your NetCode again?", forState: UIControlState.Normal)

                            
                            //Enable button continue
                            self.bt_Continue.enabled = true
                            self.bt_Continue.alpha = 1
                            
                            self.tf_NetCode.alpha = 1
                            self.tf_NetCode.enabled = true
                            
                            self.lb_netcode.alpha = 1
                            self.lb_netcode.enabled = true
                            
                            self.tf_NetCode.becomeFirstResponder()
                            
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
            else
            {       
                self.view.hideLoading();
      
                LocalStore.Alert(self.view, title: "Error", message: "No Internet connection.", indexPath: 0)
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
}
