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
                    
                    let enteredText = theTextFields[0].text
                    
                    //Pay Other Amount
//                    self?.debtorInfo.PaymentType = 4
                    
                    //Pay In Full
                    self?.debtorInfo.PaymentType = 1
                    
                    self?.debtorInfo.EmailAddress = enteredText!
                    
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
                                let alert = UIAlertController(title: "Done", message: "Email sent", preferredStyle: UIAlertControllerStyle.Alert)
                                
                                // add an action (button)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                                
                                // show the alert
                                self!.presentViewController(alert, animated: true, completion: nil)
                            }
                            else
                            {
                                
                                // create the alert
                                let alert = UIAlertController(title: "Error", message: temp1.Errors[0].ErrorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                                
                                // add an action (button)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                                
                                // show the alert
                                self!.presentViewController(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // create the alert
                            let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            
                            // show the alert
                            self!.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                }
            })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,
            completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
