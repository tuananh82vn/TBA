//
//  SummaryViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {


    @IBOutlet weak var lb_RefNumber: UILabel!
    @IBOutlet weak var lb_Transaction: UILabel!
    @IBOutlet weak var lb_Receipt: UILabel!
    @IBOutlet weak var lb_Amount: UILabel!
    @IBOutlet weak var lb_Time: UILabel!
    @IBOutlet weak var lb_Date: UILabel!
    @IBOutlet weak var lb_Name: UILabel!
    
    var paymentReturn = PaymentReturnModel()
    var debtorInfo = DebtorInfo()
    var paymentMethod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.translucent = false

        self.navigationItem.setHidesBackButton(true, animated:true)
        

            
            self.lb_Transaction.text    = self.paymentReturn.TransactionDescription
            self.lb_Receipt.text        = self.paymentReturn.ReceiptNumber
            self.lb_Amount.text         = self.paymentReturn.Amount
            self.lb_Time.text           = self.paymentReturn.Time
            self.lb_Date.text           = self.paymentReturn.Date
            self.lb_Name.text           = self.paymentReturn.Name
            self.lb_RefNumber.text  = "Your Payment has been processed for you account with Reference Number " + LocalStore.accessRefNumber()! + ". Please be aware, payments will appear on your statement as payment for 'Recoveriescorp'"


    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        self.performSegueWithIdentifier("GoToHomepage", sender: nil)

    }

    @IBAction func btEmail_Clicked(sender: AnyObject) {
        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Enter your email",
            message: nil,
            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Email"
                textField.keyboardType = UIKeyboardType.EmailAddress
        })
        
        let action = UIAlertAction(title: "Submit",
            style: UIAlertActionStyle.Default,
            handler: {[weak self]
                (paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    
                    let theTextFields = textFields as [UITextField]
                    
                    if let enteredText = theTextFields[0].text
                    {
                    
                    if(enteredText.isEmailAddress())
                    {
                    
                    var PaymentType = 0
                    
                    //        1: Pay In Full
                    //        2: Pay In 3 Part
                    //        3: Pay In Installment
                    //        4: Pay Other Amount
                    //        5: Pay Next Instalment
                    
                    if(LocalStore.accessMakePaymentInFull()){
                        PaymentType = 1
                    }
                    else if(LocalStore.accessMakePaymentIn3Part()){
                        PaymentType = 2
                    }
                    else if(LocalStore.accessMakePaymentInstallment()){
                        PaymentType = 3
                    }
                    else if(LocalStore.accessMakePaymentOtherAmount()){
                        PaymentType = 4
                    }

                    self?.debtorInfo.PaymentType = PaymentType
                    
                    self?.debtorInfo.EmailAddress = enteredText
                    
                    self?.debtorInfo.CurrentPaymentId = self!.paymentReturn.PaymentId
                    
                    self?.debtorInfo.ClientName = self!.paymentReturn.ClientName
                    
                    self?.debtorInfo.Name = self!.paymentReturn.Name
                    

                    WebApiService.emailReceipt(self!.debtorInfo){ objectReturn in
                        
                        self!.view.hideLoading();
                        
                        if let temp1 = objectReturn
                        {
                            
                            if(temp1.IsSuccess)
                            {
                                // create the alert
//                                let alert = SCLAlertView()
//                                alert.hideWhenBackgroundViewIsTapped = true
//                                alert.showInfo("Error", subTitle:"Invoice has been sent to " + enteredText)
                                if(self!.paymentMethod == 0){
                                    LocalStore.Alert(self!.view, title: "Notice", message: "Receipt has been sent to " + enteredText, indexPath: 3)
                                }
                                else
                                {
                                    LocalStore.Alert(self!.view, title: "Notice", message: "Payment summary has been sent to " + enteredText, indexPath: 3)
                                }
                            }
                            else
                            {
                                
                                // create the alert
//                                let alert = SCLAlertView()
//                                alert.hideWhenBackgroundViewIsTapped = true
//                                alert.showError("Error", subTitle:temp1.Errors[0].ErrorMessage)
                                
                                LocalStore.Alert(self!.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)

                            }
                        }
                        else
                        {
                            // create the alert
//                            let alert = SCLAlertView()
//                            alert.hideWhenBackgroundViewIsTapped = true
//                            alert.showError("Error", subTitle:"Server not found.")
                            
                            LocalStore.Alert(self!.view, title: "Error", message: "Server not found.", indexPath: 0)

                        }
                    }
                    }
                    else
                    {
                        // create the alert
//                        let alert = SCLAlertView()
//                        alert.hideWhenBackgroundViewIsTapped = true
//                        alert.showError("Error", subTitle: enteredText + " is not a valid email.")
                        
                        LocalStore.Alert(self!.view, title: "Error", message: "Please enter a valid email.", indexPath: 0)

                    }
                }
                    
                }
            })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
    }


}
