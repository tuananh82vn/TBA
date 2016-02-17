//
//  MakeDebitPaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeDebitPaymentViewController: UIViewController , TKDataFormDelegate  {

    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    var paymentReturn = PaymentReturnModel()
    
    let bankInfo = BankInfo()
    
    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        if(LocalStore.accessMakePaymentInFull()){
            bankInfo.Amount = LocalStore.accessTotalOutstanding()
        }
        
        if(LocalStore.accessMakePaymentIn3Part()){
            bankInfo.Amount = LocalStore.accessFirstAmountOfInstalment()
        }

        
        dataSource.sourceObject = bankInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormNumberEditor.self
        dataSource["Amount"].readOnly = true
        dataSource["Amount"].index = 0
        
        dataSource["AccountName"].hintText = "Account Number"
        dataSource["AccountName"].index = 1

        dataSource["Bsb"].hidden = true
        
        dataSource["Bsb1"].hintText = "Bsb1"
        dataSource["Bsb1"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Bsb1"].errorMessage = "Please input Bsb 1"
        dataSource["Bsb1"].index = 2
        
        dataSource["Bsb2"].hintText = "Bsb2"
        dataSource["Bsb2"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Bsb2"].errorMessage = "Please input Bsb 2"
        dataSource["Bsb2"].index = 3
        
        dataSource["AccountNumber"].hintText = "Account Number"
        dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource["AccountNumber"].index = 4

        
        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self
        dataForm1.dataSource = dataSource
        
        dataForm1.backgroundColor = UIColor.whiteColor()
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        dataForm1.commitMode = TKDataFormCommitMode.Manual
        dataForm1.validationMode = TKDataFormValidationMode.Manual
        
        self.subView.addSubview(dataForm1)

        
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
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
    }
    
    func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        self.isFormValidate = true

        
        if (propery.name == "Amount") {
            
            let value = propery.valueCandidate.description
            
            if (value.length <= 0)
            {
                dataSource["Amount"].errorMessage = "Please input amount"
                self.isFormValidate = false
            }
            
            let floatValue = value.floatValue
            
            if (floatValue <= 0)
            {
                dataSource["Amount"].errorMessage = "Amount can not less than or equal 0"
                self.isFormValidate = false
            }
            
        }
        else
            if (propery.name == "AccountName") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["AccountName"].errorMessage = "Please input Account Name"
                    self.isFormValidate = false
                }
                
            }
        else
            if (propery.name == "Bsb1") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    self.isFormValidate = false
                }
                else
                    if (value.length > 3)
                    {
                        dataSource["Bsb1"].errorMessage = "Bsb 1 is maximum 3 number in lenght"
                        self.isFormValidate = false
                    }
                
            }
            else
                if (propery.name == "Bsb2") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        self.isFormValidate = false
                    }
                    else
                        if (value.length > 3)
                        {
                            dataSource["Bsb2"].errorMessage = "Bsb 2 is maximum 3 number in lenght"
                            self.isFormValidate = false
                        }
                }
                else
                    if (propery.name == "AccountNumber") {
                        
                        let value = propery.valueCandidate as! NSString
                        
                        if (value.length <= 0)
                        {
                            dataSource["AccountNumber"].errorMessage = "Please input Account Number"
                            self.isFormValidate = false
                        }
                        
                    }

        return isFormValidate
   }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
        self.dataForm1.commit()
        
        if(!self.isFormValidate){
            
            return
        }
        
        view.showLoading()
        
        let bankObject = BankInfo()
        
        bankObject.Amount           = self.dataSource["Amount"].valueCandidate.doubleValue
        bankObject.AccountNumber    = self.dataSource["AccountNumber"].valueCandidate as! String
        bankObject.AccountName      = self.dataSource["AccountName"].valueCandidate as! String
        bankObject.Bsb1             = self.dataSource["Bsb1"].valueCandidate as! String
        bankObject.Bsb2             = self.dataSource["Bsb2"].valueCandidate as! String


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
