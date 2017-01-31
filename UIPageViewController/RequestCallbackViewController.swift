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

    var CallbackSlot = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RequestCallbackViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.getCallbackSlot("",time: "", isInit: true);

        WebApiService.sendActivityTracking("Open Schedule Callback")

    }
    
    func getCallbackSlot(_ date : String, time : String, isInit : Bool){
        
        self.view.showLoading()
        var dateTmp = "";
        var timeTmp = "";
        
        if(date.isEmpty)
        {
            dateTmp  = Date().formattedWith("yyyy/MM/dd")
        }
        else{
            dateTmp = date
        }
        
        if(time.isEmpty){
            timeTmp = Date().formattedWith("HH:mm:ss")
        }
        else
        {
            timeTmp = time
        }
        
    
        WebApiService.GetCallBackTime(LocalStore.accessRefNumber()!,CallbackDate: dateTmp, CallbackTimeSlot: timeTmp) { objectReturn in
            
            if let temp1 = objectReturn
            {
                
                self.view.hideLoading()
                
                if(temp1.IsSuccess){
                    
                    if(isInit)
                    {
                        self.dataSource.sourceObject = self.requestCallBack
                    
                        self.dataSource["Name"].hintText = "Name"
                        self.dataSource["Name"].errorMessage = "Please enter your name"
                    
                        self.dataSource["Phone"].hintText = "Number"
                        self.dataSource["Phone"].errorMessage = "Please enter your number"
                        self.dataSource["Phone"].editorClass = TKDataFormPhoneEditor.self
                    
                        self.dataSource["Date"].hintText = "Date"
                    
                        self.dataSource["CallBackTimeSlot"].hintText = "Time"
                        self.dataSource["CallBackTimeSlot"].errorMessage = "Please select time slot"
                        
                        self.dataSource["CallBackTimeSlotValue"].hidden = true

                    }
                
                    self.CallbackSlot = temp1.CallbackSlot
                    self.dataSource["CallBackTimeSlot"].valuesProvider = self.CallbackSlot
                    
                    if(isInit)
                    {
                    
                    self.dataSource["CallBackTimeSlot"].editorClass = TKDataFormPickerViewEditor.self
                    
                    self.dataSource["Notes"].hintText = "Notes"
                    self.dataSource["Notes"].editorClass = TKDataFormMultilineTextEditor.self
                    
                    self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                    
                    self.dataForm1.dataSource = self.dataSource
                    self.dataForm1.delegate = self
                    
                    self.dataForm1.commitMode = TKDataFormCommitMode.manual
                    self.dataForm1.validationMode = TKDataFormValidationMode.immediate
                    
                    
                    self.dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
                    
                    self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
                    
                    self.subView.addSubview(self.dataForm1)
                        
                    }
                    
                    if(!isInit){
                     self.dataForm1.reloadData()
                    }
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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if propery.name == "Name" {
            
            let value = (propery.valueCandidate as AnyObject).description

            if((value?.length)! <= 0)
            {
                self.validate1 = false
                return self.validate1
            }
            
            self.validate1 = true
        }
        
        if propery.name == "Phone"
        {
            let value = (propery.valueCandidate as AnyObject).description

            if((value?.length)! <= 0)
            {
                self.validate2 = false
                return self.validate2
            }
            
            if(!(value?.isPhoneNumber())!){
                
                dataSource["Phone"].errorMessage = "Phone Number is not valid"

                self.validate2 = false
                return self.validate2
            }

            self.validate2 = true
        }
        
        if propery.name == "Date"
        {
            let value = propery.valueCandidate as! Date
            

            let firstDate = Calendar.current.startOfDay(for: Date())
            
            var timeInterval = DateComponents()
            timeInterval.day = 7
            let futureDate = Calendar.current.date(byAdding: timeInterval, to: Date())!
            
            
            if(value.isLessThanDate(firstDate)){
                dataSource["Date"].errorMessage = "Date must not be earlier than today"
                self.validate3 = false
                return self.validate3
            }
            else if(value.isGreaterThanDate(futureDate)){
                dataSource["Date"].errorMessage = "Date must not be later than 7 days from today"
                self.validate3 = false
                return self.validate3
            }
            else
            {
                self.getCallbackSlot(value.formattedWith("yyyy/MM/dd"), time: "", isInit: false)
            }
            
            self.validate3 = true
        }
        
        return true
        
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        if (property.name == "Notes") {
            let textEditor = editor as! TKDataFormMultilineTextEditor
            textEditor.textView.font = UIFont.systemFont(ofSize: 20)
        }
//        else
//            if (property.name == "Date") {
//                let textEditor = editor as! TKDataFormDatePickerEditor
//                textEditor.datePicker.setValue(UIColor.blueColor(), forKey: "textColor")
//                textEditor.datePicker.datePickerMode = .Date
//        }
    }
    
    func dataForm(_ dataForm: TKDataForm, update groupView: TKEntityPropertyGroupView, forGroupAt groupIndex: UInt) {

    }
    
    func dataForm(_ dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, at editorIndex: UInt) -> CGFloat {
        if gorupIndex == 0 && editorIndex == 5 {
            return 100
        }
        
        return 30
    }


    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        self.dataForm1.commit()
        
        self.isFormValidate = self.validate1 && self.validate2 && self.validate3
        
        if(self.isFormValidate){
            view.showLoading()
            
            let requestObject = RequestCallBack()
            
            requestObject.Notes         = self.dataSource["Notes"].valueCandidate as! String
            requestObject.Phone         = self.dataSource["Phone"].valueCandidate as! String
            requestObject.Name          = self.dataSource["Name"].valueCandidate as! String
            requestObject.Date          = self.dataSource["Date"].valueCandidate as! Date
            requestObject.CallBackTimeSlot      = self.dataSource["CallBackTimeSlot"].valueCandidate as! Int
            requestObject.CallBackTimeSlotValue  = self.CallbackSlot[requestObject.CallBackTimeSlot]
            
            
            WebApiService.RequestCallback(requestObject){ objectReturn in
                
                self.view.hideLoading();
                
                if let temp1 = objectReturn
                {
                    
                    if(temp1.IsSuccess)
                    {
                        self.performSegue(withIdentifier: "GoToNotice", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "Callback request successfully submitted. One of our friendly operators will call you on the day and time you have requested"
        
        }
    }


}
