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
                    self.paymentInfo.ExpiryDate = temp1.card.ExpiryDate
                
                
                    self.dataSource.sourceObject = self.paymentInfo
                

                    self.dataSource["CardNumber"].hintText = "Card Number"
                    self.dataSource["CardNumber"].editorClass = TKDataFormPhoneEditor.self
                
                    let DateFormatter = NSDateFormatter()
                    DateFormatter.dateFormat = "MM/yyyy";
                
                    self.dataSource["ExpiryDate"].editorClass = TKDataFormDatePickerEditor.self
                    self.dataSource["ExpiryDate"].formatter = DateFormatter
                
                
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
                    LocalStore.Alert(self.view, title: "Error", message: temp1.Errors, indexPath: 0)

                }
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
                else
                    if (propery.name == "ExpiryDate") {
                        
                        let value = propery.valueCandidate as! NSDate
                        
                        
                        let firstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
                        
                        if(value.isLessThanDate(firstDate)){
                            dataSource["ExpiryDate"].errorMessage = "Expire month must be greater than current month"
                            self.validate2 = false
                            return self.validate2
                        }
                        
                        
                        self.validate2 = true

                }


        return true
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
        self.dataForm1.commit()
        
        self.isFormValidate = self.validate1 && self.validate2
        
        if(!self.isFormValidate){
            
            return
        }
        
        self.view.showLoading();
        
        let paymentInfo = PaymentInfo()
        
        paymentInfo.card.CardNumber         = self.dataSource["CardNumber"].valueCandidate as! String
        paymentInfo.card.ExpiryDate         = self.dataSource["ExpiryDate"].valueCandidate as! NSDate

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
            controller.message = "Your credit card has been updated successfully."
            
        }
    }

}
