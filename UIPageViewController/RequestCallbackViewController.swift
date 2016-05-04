//
//  RequestCallbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import PhoneNumberKit


class RequestCallbackViewController: UIViewController , TKDataFormDelegate  {


    let dataSource = TKDataFormEntityDataSource()
    
    let requestCallBack = RequestCallBack()
    
    var alignmentMode: String = ""


    @IBOutlet weak var subView: UIView!
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true
    
    var dataForm1 = TKDataForm()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        dataSource.sourceObject = requestCallBack
        
        dataSource["Name"].hintText = "Name"
        dataSource["Name"].errorMessage = "Please enter your name"
        
        dataSource["Phone"].hintText = "Number"
        dataSource["Phone"].errorMessage = "Please enter your number"
        dataSource["Phone"].editorClass = TKDataFormPhoneEditor.self
        
        dataSource["Date"].hintText = "Date"
        

        let TimeFormatter = NSDateFormatter()
        TimeFormatter.dateFormat = "h:mm a";
        

        dataSource["TimeFrom"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeFrom"].hintText = "From"
        dataSource["TimeFrom"].formatter = TimeFormatter

        
        dataSource["TimeTo"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeTo"].hintText = "To"
        dataSource["TimeTo"].formatter = TimeFormatter


        dataSource["Notes"].hintText = "Notes"
        dataSource["Notes"].editorClass = TKDataFormMultilineTextEditor.self
        
        dataForm1 = TKDataForm(frame: self.subView.bounds)

        dataForm1.dataSource = dataSource
        dataForm1.delegate = self

        dataForm1.commitMode = TKDataFormCommitMode.Manual
        dataForm1.validationMode = TKDataFormValidationMode.Manual


        dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)

        self.subView.addSubview(dataForm1)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if propery.name == "Name" {
            
            let value = propery.valueCandidate.description

            if(value.length <= 0)
            {
                self.validate1 = false
                return self.validate1
            }
            
            self.validate1 = true
        }
        
        if propery.name == "Phone"
        {
            let value = propery.valueCandidate.description

            if(value.length <= 0)
            {
                self.validate2 = false
                return self.validate2
            }
            
            if(!value.isPhoneNumber()){
                
                dataSource["Phone"].errorMessage = "Phone Number is not valid"

                self.validate2 = false
                return self.validate2
            }

            self.validate2 = true
        }
        
        if propery.name == "Date"
        {
            let value = propery.valueCandidate as! NSDate
            

            let firstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
            
            if(value.isLessThanDate(firstDate)){
                dataSource["Date"].errorMessage = "Date must not be earlier than today"
                self.validate3 = false
                return self.validate3
            }
            
            self.validate3 = true
        }
        
        return true
        
    }
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if (property.name == "Notes") {
            let textEditor = editor as! TKDataFormMultilineTextEditor
            textEditor.textView.font = UIFont.systemFontOfSize(20)
        }
//        else
//            if (property.name == "Date") {
//                let textEditor = editor as! TKDataFormDatePickerEditor
//                textEditor.datePicker.setValue(UIColor.blueColor(), forKey: "textColor")
//                textEditor.datePicker.datePickerMode = .Date
//        }
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {

    }
    
    func dataForm(dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, atIndex editorIndex: UInt) -> CGFloat {
        if gorupIndex == 0 && editorIndex == 5 {
            return 100
        }
        
        return 30
    }


    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        self.dataForm1.commit()
        
        self.isFormValidate = self.validate1 && self.validate2 && self.validate3
        
        if(self.isFormValidate){
            view.showLoading()
            
            let requestObject = RequestCallBack()
            
            requestObject.Notes         = self.dataSource["Notes"].valueCandidate as! String
            requestObject.Phone         = self.dataSource["Phone"].valueCandidate as! String
            requestObject.Name          = self.dataSource["Name"].valueCandidate as! String
            requestObject.Date          = self.dataSource["Date"].valueCandidate as! NSDate
            requestObject.TimeFrom      = self.dataSource["TimeFrom"].valueCandidate as! NSDate
            requestObject.TimeTo        = self.dataSource["TimeTo"].valueCandidate as! NSDate
            
            
            WebApiService.RequestCallback(requestObject){ objectReturn in
                
                self.view.hideLoading();
                
                if let temp1 = objectReturn
                {
                    
                    if(temp1.IsSuccess)
                    {
                        self.performSegueWithIdentifier("GoToNotice", sender: nil)
                    }
                    else
                    {

                        
                        if(temp1.Errors.count > 0){
                            LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                        }
                        else
                        {
                            LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                        }                    }
                }
                else
                {
                    
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)

                }
            }

        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Callback request successfully submitted. One of our friendly operators will call you on the day and time you have requested"
        
        }
    }


}