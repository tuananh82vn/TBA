//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeCreditPaymentViewController: UIViewController , TKDataFormDelegate  {

    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    var paymentReturn = PaymentReturnModel()
    

    var dataForm1 = TKDataForm()
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()
    
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
            cardInfo.Amount = LocalStore.accessTotalOutstanding()
        }
        
        if(LocalStore.accessMakePaymentIn3Part()){
            cardInfo.Amount = LocalStore.accessFirstAmountOfInstalment()
        }
        
        dataSource.sourceObject = cardInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormNumberEditor.self
        
        if(LocalStore.accessMakePaymentInFull()){
            dataSource["Amount"].readOnly = true
        }
        if(LocalStore.accessMakePaymentIn3Part()){
            dataSource["Amount"].readOnly = true
        }
        
        dataSource["CardType"].valuesProvider = [ "Visa", "Master" ]
        

        dataSource["NameOnCard"].hintText = "Name On Card"
        dataSource["NameOnCard"].errorMessage = "Please input name"

        dataSource["CardNumber"].hintText = "Card Number"
        dataSource["CardNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource["CardNumber"].errorMessage = "Please input card number"

        dataSource["Cvv"].hintText = "Card Security Code"
        dataSource["Cvv"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Cvv"].errorMessage = "Please input CVV"

        dataSource["DebtorPaymentInstallment"].hidden = true
        
        
        let DateFormatter = NSDateFormatter()
        DateFormatter.dateFormat = "MM/yyyy";
        
        dataSource["ExpiryDate"].editorClass = TKDataFormDatePickerEditor.self
        dataSource["ExpiryDate"].formatter = DateFormatter

        
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
        if property.name == "Cvv" {
            (editor.editor as! UITextField).secureTextEntry = true;
        }
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
        if (propery.name == "NameOnCard") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                self.validate2 = false
                return self.validate2

            }
            
            self.validate2 = true


        }
        else
        if (propery.name == "CardNumber") {
            
            let value = propery.valueCandidate.description
            
            if (value.length <= 0)
            {
                self.validate3 = false
                return self.validate3

            }
            else
            {
                
                let v = CreditCardValidator()
                
                if v.validateString(value) {
                    
                    self.validate3 = true
                    
                }
                else
                {
                    
                    self.dataSource["CardNumber"].errorMessage = "Card Number is not valid"
                    self.validate3 = false
                    
                }
                
                return self.validate3

            }
            
        }
        else
        if (propery.name == "Cvv") {
            
            let value = propery.valueCandidate.description
            if (value.length <= 0)
            {
                self.validate4 = false
                return self.validate4
            }
            
            self.validate4 = true
            
        }
        return true
    }

    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
        self.dataForm1.commit()

        self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4
        
        if(!self.isFormValidate){
            
            return
        }
        
        view.showLoading()
        
        let cardObject = CardInfo()
        
        cardObject.Amount       = self.dataSource["Amount"].valueCandidate.doubleValue
        cardObject.CardNumber   = self.dataSource["CardNumber"].valueCandidate as! String
        cardObject.ExpiryDate   = self.dataSource["ExpiryDate"].valueCandidate as! NSDate
        cardObject.Cvv          = self.dataSource["Cvv"].valueCandidate as! String
        cardObject.NameOnCard   = self.dataSource["NameOnCard"].valueCandidate as! String
        cardObject.CardType     = self.dataSource["CardType"].valueCandidate as! Int
        
        if(LocalStore.accessMakePaymentIn3Part()) {
            
        //Generate Debtor Payment Installment
            
        
            let jsonCompatibleArray = DebtorPaymentInstallmentList.map { model in
                return [
                    "PaymentDate":model.PaymentDate,
                    "Amount":model.Amount
                ]
            }
 
            let data = try?  NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions(rawValue:0))
        
            if let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            {
                cardObject.DebtorPaymentInstallment = jsonString as String
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
        
 
        WebApiService.MakeCreditCardPayment(cardObject, PaymentType: PaymentType){ objectReturn in
        
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

class DateMonthEditor: TKDataFormDatePickerEditor {
    
    
    override init(property: TKEntityProperty, owner: TKDataForm) {
        super.init(property: property, owner: owner)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
}





