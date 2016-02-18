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
    
    var paymentInfo = UpdateCardInfo()
    
//    var paymentReturn = PaymentReturnModel()
    
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


                    self.paymentInfo.CardNumber = temp1.card.CardNumber
                    self.paymentInfo.ExpiryDate = temp1.card.ExpiryDate
                
                
                    self.dataSource.sourceObject = self.paymentInfo
                

                    self.dataSource["CardNumber"].hintText = "Card Number"
                    self.dataSource["CardNumber"].editorClass = TKDataFormNumberEditor.self
                
                
                    let dataForm = TKDataForm(frame: self.subView.bounds)
                    dataForm.delegate = self
                    dataForm.dataSource = self.dataSource
                    dataForm.backgroundColor = UIColor.whiteColor()
                    dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                

                    self.subView.addSubview(dataForm)
                
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

    }
    
    override func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {

                if (propery.name == "CardNumber") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        dataSource["CardNumber"].errorMessage = "Please input card number"
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
                    self.performSegueWithIdentifier("GoToNotice", sender: nil)

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
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your credit card has been updated successfully."
            
        }
    }

}
