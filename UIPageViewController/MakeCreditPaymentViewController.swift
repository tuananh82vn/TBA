//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeCreditPaymentViewController: TKDataFormViewController {

    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    var paymentReturn = PaymentReturnModel()
    
    var isFormValidate : Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        cardInfo.Amount = (LocalStore.accessTotalOutstanding()?.floatValue)!
//        cardInfo.Cvv = "123"
//        cardInfo.NameOnCard = "Andy Pham"
//        cardInfo.CardNumber = "4444333322221111"
        
        dataSource.sourceObject = cardInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        dataSource["Amount"].readOnly = true
        
        dataSource["CardType"].valuesProvider = [ "Visa", "Master" ]
        

        dataSource["NameOnCard"].hintText = "Name On Card"
        dataSource["NameOnCard"].errorMessage = "Please input name"

        dataSource["CardNumber"].hintText = "Card Number"
        dataSource["CardNumber"].editorClass = TKDataFormNumberEditor.self
        
        dataSource["Cvv"].hintText = "Card Security Code"
        dataSource["Cvv"].editorClass = TKDataFormNumberEditor.self
        
        let dataForm = TKDataForm(frame: self.subView.bounds)
        dataForm.delegate = self
        dataForm.dataSource = dataSource
        dataForm.backgroundColor = UIColor.whiteColor()
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        self.dataForm.commitMode = TKDataFormCommitMode.OnLostFocus
        self.dataForm.validationMode = TKDataFormValidationMode.Manual

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
        if property.name == "Cvv" {
            (editor.editor as! UITextField).secureTextEntry = true;
        }
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
            
//            if (floatValue >  1000)
//            {
//                dataSource["Amount"].errorMessage = "Amount can not greater than $1000"
//                return false
//            }
        }
        else
        if (propery.name == "NameOnCard") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                self.isFormValidate = false
                return false
            }

        }
        else
        if (propery.name == "CardNumber") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["CardNumber"].errorMessage = "Please input card number"
                return false
            } 
        }
        else
            if (propery.name == "CardType") {
                
                let value = propery.valueCandidate as! Int
                
                if (value < 0)
                {
                    dataSource["CardType"].errorMessage = "Please select card type"
                    return false
                }
                
        }
        else
        if (propery.name == "Cvv") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["Cvv"].errorMessage = "Please input CVV"
                return false
            }
            
        }
        return true
    }

    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        self.dataForm.commit()
        
        if(!self.isFormValidate){
            
            // create the alert
            let alert = UIAlertController(title: "Error", message: "form not validate", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
            
        }
        
//        view.showLoading()
//        
//        let cardObject = CardInfo()
//        
//        cardObject.Amount       = self.dataSource["Amount"].valueCandidate.floatValue
//        cardObject.CardNumber   = self.dataSource["CardNumber"].valueCandidate as! String
//        cardObject.ExpiryDate   = self.dataSource["ExpiryDate"].valueCandidate as! NSDate
//        cardObject.Cvv          = self.dataSource["Cvv"].valueCandidate as! String
//        cardObject.NameOnCard   = self.dataSource["NameOnCard"].valueCandidate as! String
//        cardObject.CardType     = self.dataSource["CardType"].valueCandidate as! Int
//
//
//        // Pay in FULL
//        let PaymentType = 1
// 
//        WebApiService.MakeCreditCardPayment(cardObject, PaymentType: PaymentType){ objectReturn in
//        
//            self.view.hideLoading();
//
//            if let temp1 = objectReturn
//            {
//        
//                if(temp1.IsSuccess)
//                {
//                        self.paymentReturn = temp1
//                    
//                        self.performSegueWithIdentifier("GoToSummary", sender: nil)
//                }
//                else
//                {
//                    
//                    // create the alert
//                    let alert = UIAlertController(title: "Error", message: temp1.Errors[0].ErrorMessage, preferredStyle: UIAlertControllerStyle.Alert)
//                    
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                    
//                    // show the alert
//                    self.presentViewController(alert, animated: true, completion: nil)
//                }
//            }
//            else
//            {
//                // create the alert
//                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
//                
//                // add an action (button)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                
//                // show the alert
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToSummary" {
            
            let controller = segue.destinationViewController as! SummaryViewController
            controller.paymentReturn = self.paymentReturn
        }
    }

}



