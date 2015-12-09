//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakePaymentViewController: TKDataFormViewController {

    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        cardInfo.Amount = (LocalStore.accessTotalOutstanding()?.floatValue)!
        
        dataSource.sourceObject = cardInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self

        dataSource["NameOnCard"].hintText = "Name On Card"
        
        dataSource["CardNumber"].hintText = "Card Number"
        dataSource["CardNumber"].editorClass = TKDataFormNumberEditor.self
        
        dataSource["CVV"].hintText = "Card Security Code"
        dataSource["CVV"].editorClass = TKDataFormNumberEditor.self
        
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
        if property.name == "CVV" {
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
            
            if (floatValue >  1000)
            {
                dataSource["Amount"].errorMessage = "Amount can not greater than $1000"
                return false
            }
        }
        else
        if (propery.name == "NameOnCard") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["NameOnCard"].errorMessage = "Please input name"
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
        if (propery.name == "CVV") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["CVV"].errorMessage = "Please input CVV"
                return false
            }
            
        }
        return true
    }

    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        //dataForm.commit()
        
        view.showLoading()
        
        var cardObject = CardInfo()
        
        cardObject.Amount       = self.dataSource["Amount"].valueCandidate.floatValue
        cardObject.CardNumber   = self.dataSource["CardNumber"].valueCandidate as! String
        cardObject.ExpiryDate   = self.dataSource["ExpiryDate"].valueCandidate as! NSDate
        cardObject.CVV          = self.dataSource["CVV"].valueCandidate as! String
        

        
        


                WebApiService.MakeCreditCardPayment(cardObject){ objectReturn in
        
                    if let temp1 = objectReturn
                    {
                        self.view.hideLoading();
        
                        if(temp1.IsSuccess)
                        {
                            TelerikAlert.ShowAlert(self.subView, title: "Paid", message: "Paid Successful", style: "Info")
                        }
                        else
                        {
                            TelerikAlert.ShowAlert(self.subView, title: "Error", message: "Invalid card number", style: "Error")
                        }
                    }
                }
    }
    



}
