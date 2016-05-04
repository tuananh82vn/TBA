//
//  VerifyDetailCoDebtorViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 22/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit
import Foundation

class VerifyDetailCoDebtorViewController: UIViewController , TKDataFormDelegate  {


    
    let dataSource = TKDataFormEntityDataSource()

    
    @IBOutlet weak var subView: UIView!
    
    var selectedDebtor = CoDebtor()
    
    let debtorDetail = DebtorDetail()

    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var errorMessage = "We could not verify your details. Please enter your verification details exactly as printed on your letter, or contact RecoveriesCorp on 03 8627 0600"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        loadMoreData()

        
    }
    
    func loadMoreData(){
        //Get net code
        WebApiService.GetDebtorAdditonalInfo(LocalStore.accessRefNumber()!, DebtorCode : self.selectedDebtor.DebtorCode){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {

                    self.selectedDebtor.DateOfBirth = temp1.DateOfBirths.dateFromString2("yyyy-MM-dd")

                    self.selectedDebtor.PostCode = temp1.PostCode
                    
                    self.dataSource.sourceObject = self.debtorDetail
                    
                    self.dataSource["FullName"].hintText = "Full Name"
                    
                    
                    let DateFormatter = NSDateFormatter()
                    DateFormatter.dateFormat = "dd/MM/yyyy";
                    
                    self.dataSource["DateOfBirth"].editorClass = TKDataFormDatePickerEditor.self
                    self.dataSource["DateOfBirth"].formatter = DateFormatter
                    
                    
                    if(self.selectedDebtor.PostCode.length == 0){
                        self.dataSource["PostCode"].hidden = true
                    }
                    else
                    {
                        self.dataSource["PostCode"].hintText = "Post Code"
                        self.dataSource["PostCode"].editorClass = TKDataFormPhoneEditor.self
                    }
                    
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

                    if(temp1.Errors.count > 0){
                        LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                    }
                    else
                    {
                        LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                    }
                    
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
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        
        if (propery.name == "FullName") {
            
            let value = propery.valueCandidate.description
            if (value.length <= 0)
            {
                dataSource["FullName"].errorMessage = "Please enter your full name"
                self.validate1 = false
                return self.validate1
            }
            
            self.validate1 = true
        }
            else
                if (propery.name == "PostCode") {
                    
                    let value = propery.valueCandidate.description
                    
                    
                    if(self.selectedDebtor.PostCode.length == 0){
                        
                        if (value.length <= 0)
                        {
                            dataSource["PostCode"].errorMessage = "Please enter postcode"

                            self.validate2 = false
                            return self.validate2
                        
                        }
                        
                    }
                    self.validate2 = true

                    
                }
                else
                    if (propery.name == "DateOfBirth") {
                        
                        let value = propery.valueCandidate.description
                        
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
        
        
        let fullName = dataSource["FullName"].valueCandidate.description
        let dateOfBirth = dataSource["DateOfBirth"].valueCandidate  as! NSDate
        let postCode = dataSource["PostCode"].valueCandidate.description
        
        if(fullName.lowercaseString.trim() == self.selectedDebtor.FullName.lowercaseString.trim())
        {
            let order = NSCalendar.currentCalendar().compareDate(dateOfBirth, toDate: self.selectedDebtor.DateOfBirth,
                toUnitGranularity: .Day)
            
            if(order == NSComparisonResult.OrderedSame){
                
                
                if( postCode.trim() ==  self.selectedDebtor.PostCode.trim())
                {
                    
                    
                    LocalStore.setIsCoBorrowersSelected(true)
                    
                    LocalStore.setDebtorCodeSelected(self.selectedDebtor.DebtorCode)
                    
                    if(self.selectedDebtor.DebtorCode == LocalStore.accessArrangementDebtor())
                    {
                        LocalStore.setIsArrangementUnderThisDebtor(true)
                    }
                    else
                    {
                        LocalStore.setIsArrangementUnderThisDebtor(false)
                        
                    }

                    LocalStore.setDRCode(self.selectedDebtor.DebtorCode)
                    
                    self.performSegueWithIdentifier("GoToSetupPin", sender: nil)

                }
                else
                {
                    
                    LocalStore.Alert(self.view, title: "Error", message: errorMessage, indexPath: 0)

                }
            }
            else
            {
                
                LocalStore.Alert(self.view, title: "Error", message: errorMessage, indexPath: 0)

            }
  
        }
        else
        {
            
            LocalStore.Alert(self.view, title: "Error", message: errorMessage, indexPath: 0)

        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
