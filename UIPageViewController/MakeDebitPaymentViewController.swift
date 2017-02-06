//
//  MakeDebitPaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeDebitPaymentViewController: UIViewController , TKDataFormDelegate , UITextViewDelegate  {

    @IBOutlet weak var sw_Agree: UISwitch!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    let dataSource = TKDataFormEntityDataSource()
    var paymentReturn = PaymentReturnModel()
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()

    
    let bankInfo = BankInfo()
    
    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true
    
    var isProcesing : Bool = false

    var isClicked : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        
        let phoneUrl = NSURL(string: "tel:+0404221082")!
        let attributes = [NSLinkAttributeName: phoneUrl]
        let attributedString = NSAttributedString(string: "Direct Debit Terms & Conditions", attributes: attributes)
        
        
        textView.attributedText = NSAttributedString(string: "I acknowledge RecoveriesCorp will use my Direct Debit details for this payment arrangement. I have read and agree to the ") + attributedString
        
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = false

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MakeDebitPaymentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if(LocalStore.accessMakePaymentInFull()){
            bankInfo.Amount = LocalStore.accessTotalOutstanding()
        }
        
        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()){
            bankInfo.Amount = LocalStore.accessFirstAmountOfInstalment()
        }

        
        dataSource.sourceObject = bankInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        dataSource["Amount"].readOnly = true
        dataSource["Amount"].index = 0
        dataSource["Amount"].displayName = "Amount ($)"
        
        dataSource["AccountName"].hintText = "Account Name"
        dataSource["AccountName"].index = 1

        dataSource["BSB"].hidden = true
        
        dataSource["BSB1"].hintText = "BSB 1"
        dataSource["BSB1"].editorClass = TKDataFormPhoneEditor.self
        dataSource["BSB1"].index = 2
        dataSource["BSB1"].displayName = "BSB 1"

        
        dataSource["BSB2"].hintText = "BSB 2"
        dataSource["BSB2"].editorClass = TKDataFormPhoneEditor.self
        dataSource["BSB2"].errorMessage = "Please enter BSB 2"
        dataSource["BSB2"].index = 3
        dataSource["BSB2"].displayName = "BSB 2"

        dataSource["AccountNumber"].hintText = "Account Number"
        dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource["AccountNumber"].index = 4
        
        dataSource["DebtorPaymentInstallment"].hidden = true


        
        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self
        dataForm1.dataSource = dataSource
        
        dataForm1.backgroundColor = UIColor.white
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
        
        dataForm1.commitMode = TKDataFormCommitMode.manual
        dataForm1.validationMode = TKDataFormValidationMode.manual
        
        self.subView.addSubview(dataForm1)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        textView.setContentOffset(CGPoint.zero, animated: false)
        
        self.isClicked = false
        
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
        
        /* perform your own custom actions here */

        if(!isClicked){
            
            self.isClicked = true
        
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DirectDebitTCViewController") as! DirectDebitTCViewController
        
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        
        return false // return true if you still want UIAlertController to pop up
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        textView.setContentOffset(CGPoint.zero, animated: false)
        
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
    }
    
    func dataForm(_ dataForm: TKDataForm, didEdit property: TKEntityProperty) {
    }
    
    func dataForm(_ dataForm: TKDataForm, update groupView: TKEntityPropertyGroupView, forGroupAt groupIndex: UInt) {
    }
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        

        
            if (propery.name == "AccountName") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["AccountName"].errorMessage = "Please enter Account Name"
                    self.validate2 = false
                    return self.validate2
                }
                
                let whitespace = CharacterSet.whitespaces
                
                let range = value.description.rangeOfCharacter(from: whitespace)
                
                // range will be nil if no whitespace is found
                if let test = range {
                    
                    let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                    
                    for index in 0 ..< fullNameArr.count
                    {
                        var fistname = fullNameArr[index] // First
                        
                        let decimalCharacters = CharacterSet.decimalDigits
                        
                        let decimalRange1 = fistname.rangeOfCharacter(from: decimalCharacters, options: NSString.CompareOptions(), range: nil)
                        
                        if decimalRange1 != nil {
                            
                            dataSource["AccountName"].errorMessage = "Account Name is not valid"
                            self.validate2 = false
                            return self.validate2
                        }

                    }
                    
                }
                else {
                    
                    dataSource["AccountName"].errorMessage = "Account Name is not valid"
                    self.validate2 = false
                    return self.validate2
                }

                self.validate2 = true
            }
        else
            if (propery.name == "BSB1") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["BSB1"].errorMessage = "Please enter BSB 1"
                    self.validate3 = false
                    return self.validate3
                }
                else
                    if (value.length > 3 || value.length < 3)
                    {
                        dataSource["BSB1"].errorMessage = "The BSB number 1 is not valid"
                        self.validate3 = false
                        return self.validate3
                    }
                
                self.validate3 = true
                
            }
            else
                if (propery.name == "BSB2") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        
                        dataSource["BSB2"].errorMessage = "Please enter BSB 1"
                        self.validate4 = false
                        return self.validate4
                    }
                    else
                        if (value.length > 3 || value.length < 3)
                        {
                            dataSource["BSB2"].errorMessage = "The BSB number 2 is not valid"
                            self.validate4 = false
                            return self.validate4
                        }
                    
                    self.validate4 = true
                }
                else
                    if (propery.name == "AccountNumber") {
                        
                        let value = propery.valueCandidate as! NSString
                        
                        if (value.length <= 0)
                        {
                            dataSource["AccountNumber"].errorMessage = "Please enter Account Number"
                            self.validate5 = false
                            return self.validate5
                        }
                        else
                            if (value.length > 15 || value.length < 5)
                            {
                                dataSource["AccountNumber"].errorMessage = "Account Number should be from 5 to 15 numeric characters in length"
                                self.validate5 = false
                                return self.validate5
                            }
                        
                        self.validate5 = true
                        
                    }

        return true
   }
    
    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        if(self.isProcesing){
            return
        }
        
        self.dataForm1.commit()
        
        self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5
        
        if(!self.isFormValidate){
            
            return
        }
        
        if(!self.sw_Agree.isOn){
            LocalStore.Alert(self.view, title: "Terms & Conditions", message: "Please agree to the Terms & Conditions to continue", indexPath: 0)
            return
        }
        
        view.showLoading()
        
        let bankObject = BankInfo()
        
        bankObject.Amount           = (self.dataSource["Amount"].valueCandidate as AnyObject).doubleValue
        bankObject.AccountNumber    = self.dataSource["AccountNumber"].valueCandidate as! String
        bankObject.AccountName      = self.dataSource["AccountName"].valueCandidate as! String
        bankObject.BSB1             = self.dataSource["BSB1"].valueCandidate as! String
        bankObject.BSB2             = self.dataSource["BSB2"].valueCandidate as! String


        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()) {
            
            let jsonCompatibleArray = DebtorPaymentInstallmentList.map { model in
                return [
                    "PaymentDate":model.PaymentDate,
                    "Amount":model.Amount
                ]
            }
            
            let data = try?  JSONSerialization.data(withJSONObject: jsonCompatibleArray, options: JSONSerialization.WritingOptions(rawValue:0))
            
            if let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                bankObject.DebtorPaymentInstallment = jsonString as String
            }
            
        }
        
        var PaymentType = 0
        
        //        1: Pay In Full
        //        2: Pay In 3 Part
        //        3: Pay In Installment
        //        4: Pay Other Amount
        //        5: Pay Next Instalment
        
        if(LocalStore.accessMakePaymentInFull()){
            PaymentType = 1
        }
        else if(LocalStore.accessMakePaymentIn3Part()){
            PaymentType = 2
        }
        else if(LocalStore.accessMakePaymentInstallment()){
            PaymentType = 3
        }
        else if(LocalStore.accessMakePaymentOtherAmount()){
            PaymentType = 4
        }

        self.isProcesing = true

        WebApiService.MakeDebitPayment(bankObject, PaymentType: PaymentType){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                    
                    WebApiService.sendActivityTracking("Make DD Payment")

                    self.paymentReturn = temp1
                    
                    self.performSegue(withIdentifier: "GoToUpdateDetail", sender: nil)
                }
                else
                {
                    self.isProcesing = false

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
                self.isProcesing = false

                LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)

            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUpdateDetail" {
            
            let controller = segue.destination as! UpdatePersonalInfoViewController
            controller.paymentReturn = self.paymentReturn
            controller.paymentMethod = 2
            controller.screenComeForm = "DDPayment"
        }
    }
    
}
