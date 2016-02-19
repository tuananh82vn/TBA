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
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_Continue.alpha = 0
            self.bt_Continue.enabled = false
        })

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
                    LocalStore.setDRCode(self.selectedDebtor.DebtorCode)

                    self.performSegueWithIdentifier("GoToBlank", sender: nil)
                }
                else
                {

                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showError("Error", subTitle:"Invalid Netcode.")
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
                            let alert = SCLAlertView()
                            alert.hideWhenBackgroundViewIsTapped = true
                            alert.showInfo("", subTitle:temp1.Errors[0].ErrorMessage)
                            

                            self.btGetNetCode.setTitle("Get your NetCode again ?", forState: UIControlState.Normal)

                            
                            //Enable button continue
                            self.bt_Continue.enabled = true
                            self.bt_Continue.alpha = 1
                            
                            
                            self.tf_NetCode.becomeFirstResponder()
                            
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
            else
            {
                
                self.view.hideLoading();
                
                let alert = SCLAlertView()
                alert.hideWhenBackgroundViewIsTapped = true
                alert.showWarning("Warning", subTitle:"No Internet connection.")
            }
        })
    }

    
}
