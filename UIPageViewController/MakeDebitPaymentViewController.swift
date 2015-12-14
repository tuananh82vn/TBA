//
//  MakeDebitPaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeDebitPaymentViewController: TKDataFormViewController {

    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    var paymentReturn = PaymentReturnModel()
    
    let bankInfo = BankInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        bankInfo.Amount = 10
        bankInfo.Bsb1 = "123"
        bankInfo.Bsb2 = "123"
        bankInfo.AccountName = "Andy Pham"
        bankInfo.AccountNumber = "4444333"
        
        dataSource.sourceObject = bankInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        
        dataSource["AccountName"].hintText = "Account Name"
        
        dataSource["Bsb1"].hintText = ""
        dataSource["Bsb1"].editorClass = TKDataFormNumberEditor.self
        dataSource["Bsb2"].hintText = ""
        dataSource["Bsb2"].editorClass = TKDataFormNumberEditor.self
        
        dataSource["AccountNumber"].hintText = "Account Number"
        dataSource["AccountNumber"].editorClass = TKDataFormNumberEditor.self
        
        
        let dataForm = TKDataForm(frame: self.subView.bounds)
        dataForm.delegate = self
        dataForm.dataSource = dataSource
        dataForm.backgroundColor = UIColor.whiteColor()
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        dataForm.validationMode = TKDataFormValidationMode.Manual
        
        
        self.subView.addSubview(dataForm)

        
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
    }
    override func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        if (propery.name == "Amount") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["Amount"].errorMessage = "Please input amount"
                return false
            }
            
            let floatValue = value.floatValue
            
            if (floatValue <= 0)
            {
                dataSource["Amount"].errorMessage = "Amount can not less than or equal 0"
                return false
            }
            
            if (floatValue >  1000)
            {
                dataSource["Amount"].errorMessage = "Amount can not greater than $1000"
                return false
            }
        }
        else
            if (propery.name == "AccountName") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["AccountName"].errorMessage = "Please input Account Name"
                    return false
                }
                
            }
        else
            if (propery.name == "Bsb1") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["Bsb1"].errorMessage = "Please input Bsb 1"
                    return false
                }
                
            }
            else
                if (propery.name == "Bsb2") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        dataSource["Bsb2"].errorMessage = "Please input Bsb 2"
                        return false
                    }
                    
                }
                else
                    if (propery.name == "AccountNumber") {
                        
                        let value = propery.valueCandidate as! NSString
                        
                        if (value.length <= 0)
                        {
                            dataSource["AccountNumber"].errorMessage = "Please input Account Number"
                            return false
                        }
                        
                    }
        
        return true
   }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        view.showLoading()
        
        var bankObject = BankInfo()
        
        bankObject.Amount           = self.dataSource["Amount"].valueCandidate.floatValue
        bankObject.AccountNumber    = self.dataSource["AccountNumber"].valueCandidate as! String
        bankObject.AccountName      = self.dataSource["AccountName"].valueCandidate as! String
        bankObject.Bsb1             = self.dataSource["Bsb1"].valueCandidate as! String
        bankObject.Bsb2             = self.dataSource["Bsb2"].valueCandidate as! String

        // Pay in FULL
        let PaymentType = 1
        
        WebApiService.MakeDebitPayment(bankObject, PaymentType: PaymentType){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                    self.paymentReturn = temp1
                    
                    self.performSegueWithIdentifier("GoToSummary", sender: nil)
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: temp1.Errors[0].ErrorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToSummary" {
            
            let controller = segue.destinationViewController as! SummaryViewController
            controller.paymentReturn = self.paymentReturn
        }
    }
    
}
