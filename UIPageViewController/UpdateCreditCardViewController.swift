//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class UpdateCreditCardViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var dataForm1 = TKDataForm()

    var paymentInfo = UpdateCardInfo()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var isError : Bool = false
    
    @IBOutlet weak var bt_Continue: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPaymentInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {

                if(temp1.IsSuccess)
                {
                    self.paymentInfo.CardNumber = temp1.card.CardNumber
                    self.paymentInfo.ExpiryMonth = temp1.card.ExpiryMonth
                    self.paymentInfo.ExpiryYear = temp1.card.ExpiryYear
                }
                
                self.dataSource.sourceObject = self.paymentInfo
                
                
                self.dataSource["CardNumber"].hintText = "Card Number"
                self.dataSource["CardNumber"].editorClass = TKDataFormPhoneEditor.self
                
                self.dataSource["ExpiryMonth"].editorClass = TKDataFormNumberEditor.self
                self.dataSource["ExpiryMonth"].hintText = "MM"
                
                self.dataSource["ExpiryYear"].editorClass = TKDataFormNumberEditor.self
                self.dataSource["ExpiryYear"].hintText = "yyyy"
                
                self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                self.dataForm1.delegate = self
                self.dataForm1.dataSource = self.dataSource
                self.dataForm1.backgroundColor = UIColor.whiteColor()
                self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                
                
                
                self.dataForm1.commitMode = TKDataFormCommitMode.Manual
                self.dataForm1.validationMode = TKDataFormValidationMode.Manual
                
                self.subView.addSubview(self.dataForm1)
            }
            else
            {
                
                LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)

            }
        }
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

                if (propery.name == "CardNumber") {
                    
                    let value = propery.valueCandidate.description
                    
                    if (value.length <= 0)
                    {
                        self.dataSource["CardNumber"].errorMessage = "Please enter card number"

                        self.validate1 = false
                        return self.validate1
                        
                    }
                    else
                    {
                        
                        let v = CreditCardValidator()
                        
                        if v.validateString(value) {
                            
                            self.validate1 = true
                            
                        }
                        else
                        {
                            
                            self.dataSource["CardNumber"].errorMessage = "Card number is not valid"
                            self.validate1 = false
                            
                        }
                        
                        return self.validate1
                        
                    }
                }
        if (propery.name == "ExpiryMonth") {
            
            
            let monthValue = propery.valueCandidate as! Int
            let yearValue = self.dataSource["ExpiryYear"].valueCandidate as! Int
            
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            
            let currentYear =  components.year
            let currentMonth = components.month
            
            if(yearValue < currentYear){
                dataSource["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                self.validate2 = false
                return self.validate2
            }
            else if(yearValue == currentYear)
            {
                if(monthValue < currentMonth){
                    dataSource["ExpiryMonth"].errorMessage = "Expire month must be later than or equal this month"
                    self.validate2 = false
                    return self.validate2
                }
                else if(monthValue > 12)
                {
                    dataSource["ExpiryMonth"].errorMessage = "Invalid month"
                    self.validate2 = false
                    return self.validate2
                }
            }
            else if(yearValue > currentYear)
            {
                if(monthValue > 12)
                {
                    dataSource["ExpiryMonth"].errorMessage = "Invalid month"
                    self.validate2 = false
                    return self.validate2
                }
            }
            
            self.validate2 = true
        }
        else
            if (propery.name == "ExpiryYear") {
                
                let yearValue = propery.valueCandidate as! Int
                
                let date = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components([.Day , .Month , .Year], fromDate: date)
                
                let currentYear =  components.year
                
                if(yearValue < currentYear){
                    dataSource["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                    dataSource["ExpiryMonth"].errorMessage = ""
                    
                    self.validate3 = false
                    return self.validate3
                }
                
                self.validate3 = true
                
                
        }


        return true
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
            self.dataForm1.commit()
            
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3
            
            if(!self.isFormValidate){
                
                return
            }
            
            self.view.showLoading();
            
            let paymentInfo = PaymentInfo()
            
            paymentInfo.card.CardNumber         = self.dataSource["CardNumber"].valueCandidate as! String
            
            paymentInfo.card.ExpiryMonth     = self.dataSource["ExpiryMonth"].valueCandidate as! Int
            
            paymentInfo.card.ExpiryYear     = self.dataSource["ExpiryYear"].valueCandidate as! Int
            
            paymentInfo.RecType = "CC"
            
            WebApiService.SetPaymentInfo(paymentInfo){ objectReturn in
                
                self.view.hideLoading();
                
                if let temp1 = objectReturn
                {
                    
                    if(temp1.IsSuccess)
                    {
                        self.performSegueWithIdentifier("GoToNotice", sender: nil)
                    }
                    else
                    {
                        LocalStore.Alert(self.view, title: "Error", message: temp1.Errors, indexPath: 0)
                    }
                }
                else
                {
                    
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                    
                }
            }
            
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your credit card has been updated successfully"
            
        }
    }

}
