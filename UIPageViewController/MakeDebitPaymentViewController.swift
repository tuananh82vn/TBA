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
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()

    
    let bankInfo = BankInfo()
    
    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true
    


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
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        dataSource["Amount"].readOnly = true
        dataSource["Amount"].index = 0
        
        dataSource["AccountName"].hintText = "Account Number"
        dataSource["AccountName"].index = 1

        dataSource["Bsb"].hidden = true
        
        dataSource["Bsb1"].hintText = "Bsb1"
        dataSource["Bsb1"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Bsb1"].index = 2
        
        dataSource["Bsb2"].hintText = "Bsb2"
        dataSource["Bsb2"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Bsb2"].errorMessage = "Please input Bsb 2"
        dataSource["Bsb2"].index = 3
        
        dataSource["AccountNumber"].hintText = "Account Number"
        dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource["AccountNumber"].index = 4
        
        dataSource["DebtorPaymentInstallment"].hidden = true


        
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
        

        if (propery.name == "Amount") {
            
            let value = propery.valueCandidate.description
            
            if (value.length <= 0)
            {
                dataSource["Amount"].errorMessage = "Please input amount"
                self.validate1 = false
                return self.validate1
            }
            
            let floatValue = value.floatValue
            
            if (floatValue <= 0)
            {
                dataSource["Amount"].errorMessage = "Amount can not less than or equal 0"
                self.validate1 = false
                return self.validate1
            }
            

            
            self.validate1 = true
            
        }
        else
            if (propery.name == "AccountName") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["AccountName"].errorMessage = "Please enter 'Account Name'"
                    self.validate2 = false
                    return self.validate2
                }
                
                let whitespace = NSCharacterSet.whitespaceCharacterSet()
                
                let range = value.description.rangeOfCharacterFromSet(whitespace)
                
                // range will be nil if no whitespace is found
                if let test = range {
                    
                    let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                    
                    for (var index = 0; index < fullNameArr.count; index++)
                    {
                        var fistname = fullNameArr[index] // First
                        
                        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
                        
                        let decimalRange1 = fistname.rangeOfCharacterFromSet(decimalCharacters, options: NSStringCompareOptions(), range: nil)
                        
                        if decimalRange1 != nil {
                            
                            dataSource["AccountName"].errorMessage = "Invalid 'Account Name'"
                            self.validate2 = false
                            return self.validate2
                        }

                    }
                    
                }
                else {
                    
                    dataSource["AccountName"].errorMessage = "Invalid 'Account Name'"
                    self.validate2 = false
                    return self.validate2
                }

                self.validate2 = true
            }
        else
            if (propery.name == "Bsb1") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["Bsb1"].errorMessage = "Please input Bsb 1"
                    self.validate3 = false
                    return self.validate3
                }
                else
                    if (value.length > 3 || value.length < 3)
                    {
                        dataSource["Bsb1"].errorMessage = "The 'BSB' number 1 is invalid"
                        self.validate3 = false
                        return self.validate3
                    }
                
                self.validate3 = true
                
            }
            else
                if (propery.name == "Bsb2") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        
                        dataSource["Bsb2"].errorMessage = "Please input Bsb 2"
                        self.validate4 = false
                        return self.validate4
                    }
                    else
                        if (value.length > 3 || value.length < 3)
                        {
                            dataSource["Bsb2"].errorMessage = "The 'BSB' number 2 is invalid"
                            self.validate4 = false
                            return self.validate4
                        }
                    
                    self.validate4 = true
                }
                else
                    if (propery.name == "AccountNumber") {
                        
                        let value = propery.valueCandidate as! NSString
                        
                        if (value.length <= 0)
                        {
                            dataSource["AccountNumber"].errorMessage = "Please enter 'Account Number'"
                            self.validate5 = false
                            return self.validate5
                        }
                        else
                            if (value.length > 15 || value.length < 5)
                            {
                                dataSource["AccountNumber"].errorMessage = "'Account Number' should be from 5 to 15 numeric characters in lenght"
                                self.validate5 = false
                                return self.validate5
                            }
                        
                        self.validate5 = true
                        
                    }

        return true
   }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
        self.dataForm1.commit()
        
        self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5
        
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


        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()) {
            
            let jsonCompatibleArray = DebtorPaymentInstallmentList.map { model in
                return [
                    "PaymentDate":model.PaymentDate,
                    "Amount":model.Amount
                ]
            }
            
            let data = try?  NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions(rawValue:0))
            
            if let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            {
                bankObject.DebtorPaymentInstallment = jsonString as String
            }
            
        }
        
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
                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showError("Error", subTitle:temp1.Errors[0].ErrorMessage)
                }
            }
            else
            {
                // create the alert
                let alert = SCLAlertView()
                alert.hideWhenBackgroundViewIsTapped = true
                alert.showError("Error", subTitle:"Server not found.")
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
