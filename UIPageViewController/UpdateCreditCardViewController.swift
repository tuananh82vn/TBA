//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class UpdateCreditCardViewController: TKDataFormViewController {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = PaymentInfo()
    
//    var paymentReturn = PaymentReturnModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
//        cardInfo.Amount = 10
//        cardInfo.Cvv = "123"
        self.paymentInfo.card.NameOnCard = "Andy Pham"
        self.paymentInfo.card.CardNumber = "4444333322221111"
        
        dataSource.sourceObject = self.paymentInfo.card
        
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        
        dataSource["CardType"].valuesProvider = [ "Visa", "Master" ]
        
        dataSource["NameOnCard"].hintText = "Name On Card"
        
        dataSource["CardNumber"].hintText = "Card Number"
        dataSource["CardNumber"].editorClass = TKDataFormNumberEditor.self
        
        dataSource["Cvv"].hintText = "Card Security Code"
        dataSource["Cvv"].editorClass = TKDataFormNumberEditor.self
        
        let dataForm = TKDataForm(frame: self.subView.bounds)
        dataForm.delegate = self
        dataForm.dataSource = dataSource
        dataForm.backgroundColor = UIColor.whiteColor()
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        dataForm.validationMode = TKDataFormValidationMode.Manual
        
        
        self.subView.addSubview(dataForm)
        
        // Do any additional setup after loading the view.
        
        
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
                    self.dataSource.sourceObject = temp1.card
                
                    self.dataForm.update()
                
                    self.dataForm.reloadData()
                
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
        
        if property.name == "Amount" {
            (editor.editor as! UITextField).hidden = true;
            
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
            editor.style.editorOffset = UIOffsetMake(10, 0)
        }
    }
    
    override func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {

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
        
        self.view.showLoading();
        
        var paymentInfo = PaymentInfo()
        
        paymentInfo.card.CardNumber         = self.dataSource["CardNumber"].valueCandidate as! String
        paymentInfo.card.ExpiryDate         = self.dataSource["ExpiryDate"].valueCandidate as! NSDate

        paymentInfo.RecType = "CC"
        
        WebApiService.SetPaymentInfo(paymentInfo){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                    // create the alert
                    let alert = UIAlertController(title: "Done", message: "Update done", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: temp1.Errors, preferredStyle: UIAlertControllerStyle.Alert)
                    
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
//        if segue.identifier == "GoToSummary" {
//            
//            let controller = segue.destinationViewController as! SummaryViewController
//            controller.paymentReturn = self.paymentReturn
//        }
    }
    
    
    
    
}
