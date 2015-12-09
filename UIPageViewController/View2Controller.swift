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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIPageControl.appearance().currentPage = 1
//        UIPageControl.appearance().updateCurrentPageDisplay()
//        println(UIPageControl.appearance().currentPage)
        
        
//        if (LocalStore.accessRefNumber()?.length > 0){
//            self.tf_DebtCode.text = LocalStore.accessRefNumber()
//        }
        
        self.tf_DebtCode.text = "706132600"
        
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
        })

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

        doGetNetCode()
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
                    
                    TelerikAlert.ShowAlert(self.view, title: "Error", message: "Invalid Netcode", style: "Error")

                    self.bt_GetNetCode.enabled = true
                    //
                    self.bt_GetNetCode.backgroundColor = UIColor.init(hex: "#30a742")
                }
                
            }
        }
 
        //Get Debtor Information
//        self.view.showLoading();
//        
//        WebApiService.GetDebtorInfo(self.tf_DebtCode.text!) { objectReturn in
//            
//            if let temp1 = objectReturn
//            {
//                self.view.hideLoading();
//                
//                if(temp1.IsSuccess)
//                {
//                    
//                    LocalStore.setRefNumber(temp1.ReferenceNumber)
//                    LocalStore.setNextPaymentInstallmentAmount(temp1.NextPaymentInstallmentAmount)
//                    LocalStore.setTotalOutstanding(temp1.TotalOutstanding.description)
//
//                    self.performSegueWithIdentifier("GoToBlank", sender: nil)
//                    
//                }
//                else
//                {
//                    
//                }
//                
//            }
//        }
    }
    
    func doGetNetCode(){
        
        self.view.showLoading();
        
        WebApiService.checkInternet({(internet:Bool) -> Void in
            
                if (internet)
                {

                     WebApiService.getNetCode(self.tf_DebtCode.text!){ objectReturn in

                     if let temp1 = objectReturn
                     {
                        self.view.hideLoading();

                        
                        if(temp1.IsSuccess)
                        {
                                TelerikAlert.ShowAlert(self.view, title: "Success", message: temp1.Errors[0].ErrorMessage, style: "Positive")
                                            
                                //disable button get net code
                                self.bt_GetNetCode.backgroundColor = UIColor.grayColor()
                                self.bt_GetNetCode.enabled = false
                                            
                                //Enable button continue
                                self.bt_Continue.enabled = true
                                self.bt_Continue.alpha = 1
                                            
                            
                               self.tf_Netcode.becomeFirstResponder()

                        }
                        else
                        {
                                TelerikAlert.ShowAlert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, style: "Error")
                        }
                    }
                    }
                }
                else
                {
                    
                    self.view.hideLoading();

                    TelerikAlert.ShowAlert(self.view, title: "Warning", message: "No connections are available.", style: "Warning")

                }
        })
    }



}
