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
    
    @IBOutlet weak var lbl_TitleReceipt: UILabel!
    
    @IBOutlet weak var lb_text_receipt: UILabel!
    
    @IBOutlet weak var lb_text_transaction: UILabel!
    
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
            self.lb_RefNumber.text  = "Your payment has been processed against your account with Reference Number " + LocalStore.accessRefNumber()! + ". Please be aware, payments will appear on your statement as payment to 'Recoveriescorp'"

        
        if(self.paymentMethod == 0){
            
            self.title = "Receipt"
            self.lbl_TitleReceipt.text = "Receipt Details"

            self.lb_Receipt.hidden = false
            self.lb_Transaction.hidden = false
            self.lb_text_receipt.hidden = false
            self.lb_text_transaction.hidden = false
            
        }
        else
        {
            self.title = "Payment Summary"
            self.lbl_TitleReceipt.text = "Payment Summary"
            
            self.lb_Receipt.hidden = true
            self.lb_Transaction.hidden = true
            self.lb_text_receipt.hidden = true
            self.lb_text_transaction.hidden = true
            
        }
        

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

                    self?.debtorInfo.PaymentMethod = self!.paymentMethod
                        
                    self?.debtorInfo.FirstDebtorPaymentInstallmentId = self!.paymentReturn.FirstDebtorPaymentInstallmentId
                        
                    WebApiService.emailReceipt(self!.debtorInfo){ objectReturn in
                        
                        self!.view.hideLoading();
                        
                        if let temp1 = objectReturn
                        {
                            
                            if(temp1.IsSuccess)
                            {

                                if(self!.paymentMethod == 0){
                                    LocalStore.Alert(self!.view, title: "Notice", message: "Receipt has been sent to " + enteredText, indexPath: 3)
                                }
                                else
                                {
                                    LocalStore.Alert(self!.view, title: "Notice", message: "Payment Summary has been sent to " + enteredText, indexPath: 3)
                                }
                            }
                            else
                            {
                                
                                LocalStore.Alert(self!.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)

                            }
                        }
                        else
                        {

                            LocalStore.Alert(self!.view, title: "Error", message: "Server not found.", indexPath: 0)

                        }
                    }
                    }
                    else
                    {
                        
                        LocalStore.Alert(self!.view, title: "Error", message: "Please enter a valid email address", indexPath: 0)

                    }
                }
                    
                }
            })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
    }

    @IBAction func savetoInbox_Clicked(sender: AnyObject) {
        
        JLToast.makeText("Coming up ...", duration: JLToastDelay.ShortDelay).show()

    }

}
