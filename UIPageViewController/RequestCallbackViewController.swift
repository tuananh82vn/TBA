//
//  RequestCallbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class RequestCallbackViewController: UIViewController , TKDataFormDelegate  {


    let dataSource = TKDataFormEntityDataSource()
    
    let requestCallBack = RequestCallBack()


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
        dataSource["Name"].errorMessage = "Please fill in your name"
        dataSource["Name"].image = UIImage(named: "guest-name")
        
        dataSource["Phone"].hintText = "Number"
        dataSource["Phone"].errorMessage = "Please fill in your number"
        dataSource["Phone"].image = UIImage(named: "phone")
        dataSource["Phone"].editorClass = TKDataFormPhoneEditor.self
        

        dataSource["Date"].image = UIImage(named: "calendar-1")
        dataSource["Date"].hintText = "Date"
        

        let TimeFormatter = NSDateFormatter()
        TimeFormatter.dateFormat = "h:mm a";
        

        dataSource["TimeFrom"].image = UIImage(named: "time")
        dataSource["TimeFrom"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeFrom"].hintText = "From"
        dataSource["TimeFrom"].formatter = TimeFormatter

        
        dataSource["TimeTo"].image = UIImage(named: "time")
        dataSource["TimeTo"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeTo"].hintText = "To"
        dataSource["TimeTo"].formatter = TimeFormatter


        dataSource["Notes"].hintText = "Notes"
        dataSource["Notes"].image = UIImage(named: "notes")
        
        
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
            self.validate2 = true
        }
        
        if propery.name == "Date"
        {
            let value = propery.valueCandidate as! NSDate
            

            let firstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
            
            if(value.isLessThanDate(firstDate)){
                dataSource["Date"].errorMessage = "Date must not be less than today"
                self.validate3 = false
                return self.validate3
            }
            
            self.validate3 = true
        }
        
        return true
        
    }
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {

    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {

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

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Callback request successfully submited. One of our friendly operators will call you on the day and time you have requested."
        
        }
    }


}