//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class MakeCreditPaymentViewController: UIViewController , TKDataFormDelegate , UITextViewDelegate {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sw_Agree: UISwitch!
    

    let dataSource2 = TKDataFormEntityDataSource()
    
    let cardInfo = CardInfo()
    
    var dataForm2 = TKDataForm()

    var paymentReturn = PaymentReturnModel()
    
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true
    
    var validate7 : Bool = true
    
    var validate8 : Bool = true
    
    var validate9 : Bool = true
    
    var validate10 : Bool = true
    
    
    var isProcesing : Bool = false
    
    var isClicked : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIMenuController.shared.menuItems = nil

        textView.delegate = self
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.setContentOffset(CGPoint.zero, animated: false)
        
        let phoneUrl = NSURL(string: "tel:+0404221082")!
        let attributes = [NSLinkAttributeName: phoneUrl]
        let attributedString = NSAttributedString(string: "Credit Card Terms & Conditions", attributes: attributes)
        
        
        textView.attributedText = NSAttributedString(string: "I acknowledge RecoveriesCorp will use my Credit Card details for this payment arrangement. I have read and agree to the ") + attributedString
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MakeCreditPaymentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        initData()
    }
    
    func initData(){
        
        self.view.showLoading()
        
        WebApiService.GetPaymentInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                self.InitCreditCardPayment()
            }
        }
    }
    
    func InitCreditCardPayment(){
        

        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()){
            cardInfo.Amount = LocalStore.accessFirstAmountOfInstalment()
        }
        else
        {
            cardInfo.Amount = LocalStore.accessTotalOutstanding()
        }
        
        dataSource2.sourceObject = cardInfo
        
        
        dataSource2["Amount"].hintText = "Amount To Pay"
        dataSource2["Amount"].displayName = "Amount ($)"
        dataSource2["Amount"].editorClass = TKDataFormDecimalEditor.self
        dataSource2["Amount"].index = 0
        
        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()){
            dataSource2["Amount"].readOnly = true
        }
        
        dataSource2["PaymentMethod"].valuesProvider = [ "Credit Card", "Direct Debit" ]
        dataSource2["PaymentMethod"].index = 1

        
        // For Credit Card
        dataSource2["CardType"].valuesProvider = [ "Visa", "Master" ]

        dataSource2["NameOnCard"].hintText = "Name On Card"
        dataSource2["NameOnCard"].errorMessage = "Please enter name"

        dataSource2["CardNumber"].hintText = "Card Number"
        dataSource2["CardNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource2["CardNumber"].errorMessage = "Please enter card number"

        dataSource2["Cvv"].hintText = "Card Security Code"
        dataSource2["Cvv"].editorClass = TKDataFormPhoneEditor.self
        dataSource2["Cvv"].errorMessage = "Please enter CVV"
        dataSource2["Cvv"].displayName = "CVV"

        dataSource2["DebtorPaymentInstallment"].hidden = true
        
        dataSource2["ExpiryDate"].hidden = true

        dataSource2["ExpiryMonth"].editorClass = TKDataFormNumberEditor.self

        dataSource2["ExpiryYear"].editorClass = TKDataFormNumberEditor.self
        
        dataSource2["CardType"].index = 2
        dataSource2["NameOnCard"].index = 3
        dataSource2["CardNumber"].index = 4
        dataSource2["Cvv"].index = 7
        dataSource2["ExpiryMonth"].index = 5
        dataSource2["ExpiryYear"].index = 6


        // For Direct Debit
        dataSource2["AccountName"].hintText = "Account Name"
        dataSource2["AccountName"].hidden = true

        dataSource2["BSB"].hidden = true

        dataSource2["BSB1"].hintText = "BSB 1"
        dataSource2["BSB1"].editorClass = TKDataFormPhoneEditor.self
        dataSource2["BSB1"].displayName = "BSB 1"
        dataSource2["BSB1"].hidden = true

        
        dataSource2["BSB2"].hintText = "BSB 2"
        dataSource2["BSB2"].editorClass = TKDataFormPhoneEditor.self
        dataSource2["BSB2"].errorMessage = "Please enter BSB 2"
        dataSource2["BSB2"].displayName = "BSB 2"
        dataSource2["BSB2"].hidden = true

        dataSource2["AccountNumber"].hintText = "Account Number"
        dataSource2["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource2["AccountNumber"].hidden = true

        ////////////////////
        
        dataForm2 = TKDataForm(frame: self.subView.bounds)
        dataForm2.dataSource = dataSource2
        dataForm2.delegate = self
        
        dataForm2.commitMode = TKDataFormCommitMode.manual
        dataForm2.validationMode = TKDataFormValidationMode.immediate
        dataForm2.allowScroll = false

        
        dataForm2.backgroundColor = UIColor.white
        dataForm2.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        dataForm2.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
        
        

        
        self.subView.addSubview(dataForm2)
        
        self.dataForm2.reloadData()

    }
    
    //Handle Term & Condition text
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        textView.setContentOffset(CGPoint.zero, animated: false)
        
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        textView.setContentOffset(CGPoint.zero, animated: false)
        
        self.isClicked = false
        
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
            /* perform your own custom actions here */
        
            if(!isClicked){
                
                self.isClicked = true
                
                let SelectedPayment = self.dataSource2["PaymentMethod"].valueCandidate as! Int
                
                if(SelectedPayment == 0){
        
                    let viewController = self.storyboard!.instantiateViewController(withIdentifier: "CreditCardTCViewController") as! CreditCardTCViewController
        
                    self.navigationController!.pushViewController(viewController, animated: true)
                }
                else
                {
                    let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DirectDebitTCViewController") as! DirectDebitTCViewController
                    
                    self.navigationController!.pushViewController(viewController, animated: true)
                }
                
            }
        
            return false // return true if you still want UIAlertController to pop up
    }


    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataForm(_ dataForm: TKDataForm, update groupView: TKEntityPropertyGroupView, forGroupAt groupIndex: UInt) {
        
    }
    
    func dataForm(_ dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, at editorIndex: UInt) -> CGFloat {
        return 30
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        if property.name == "Cvv" {
            (editor.editor as! UITextField).isSecureTextEntry = true;
        }
    }
    
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if (propery.name == "PaymentMethod") {
            let value = propery.valueCandidate as! Int
            if(value == 0){
                    dataSource2["CardType"].hidden = false
                    dataSource2["NameOnCard"].hidden = false
                    dataSource2["CardNumber"].hidden = false
                    dataSource2["Cvv"].hidden = false
                    dataSource2["ExpiryMonth"].hidden = false
                    dataSource2["ExpiryYear"].hidden = false
                
                    dataSource2["CardType"].index = 2
                    dataSource2["NameOnCard"].index = 3
                    dataSource2["CardNumber"].index = 4
                    dataSource2["Cvv"].index = 7
                    dataSource2["ExpiryMonth"].index = 5
                    dataSource2["ExpiryYear"].index = 6
                
                    dataSource2["AccountName"].hidden = true
                    dataSource2["BSB1"].hidden = true
                    dataSource2["BSB2"].hidden = true
                    dataSource2["AccountNumber"].hidden = true
                
                
                    let phoneUrl = NSURL(string: "tel:+0404221082")!
                    let attributes = [NSLinkAttributeName: phoneUrl]
                    let attributedString = NSAttributedString(string: "Credit Card Terms & Conditions", attributes: attributes)
                
                
                    textView.attributedText = NSAttributedString(string: "I acknowledge RecoveriesCorp will use my Credit Card details for this payment arrangement. I have read and agree to the ") + attributedString

            }
            else
                if(value == 1){
                    dataSource2["CardType"].hidden = true
                    dataSource2["NameOnCard"].hidden = true
                    dataSource2["CardNumber"].hidden = true
                    dataSource2["Cvv"].hidden = true
                    dataSource2["ExpiryMonth"].hidden = true
                    dataSource2["ExpiryYear"].hidden = true
                    
                    dataSource2["AccountName"].hidden = false
                    dataSource2["BSB1"].hidden = false
                    dataSource2["BSB2"].hidden = false
                    dataSource2["AccountNumber"].hidden = false
                    
                    dataSource2["AccountName"].index = 2
                    dataSource2["BSB1"].index = 3
                    dataSource2["BSB2"].index = 4
                    dataSource2["AccountNumber"].index = 5
                    
                    let phoneUrl = NSURL(string: "tel:+0404221082")!
                    let attributes = [NSLinkAttributeName: phoneUrl]
                    let attributedString = NSAttributedString(string: "Direct Debit Terms & Conditions", attributes: attributes)
                    
                    
                    textView.attributedText = NSAttributedString(string: "I acknowledge RecoveriesCorp will use my Direct Debit details for this payment arrangement. I have read and agree to the ") + attributedString

                    
            }
            self.dataForm2.reloadData()


        }

        if (propery.name == "Amount") {
            
            let value = (propery.valueCandidate as AnyObject).description
            if ((value?.length)! <= 0)
            {
                dataSource2["Amount"].errorMessage = "Please input amount"
                self.validate1 = false
                return self.validate1
            }

            let floatValue = value?.floatValue
            let minValue : Float  = 10.00

            if (floatValue! <= minValue)
            {
                dataSource2["Amount"].errorMessage = "Payment amount is less than the minimum required"
                self.validate1 = false
                return self.validate1

            }
            else
                if (Double((floatValue?.description)!) > LocalStore.accessTotalOutstanding())
                {
                    dataSource2["Amount"].errorMessage = "Payment amount must be less than or equal with the outstanding amount"
                    self.validate1 = false
                    return self.validate1
                }
            
            self.validate1 = true
        }
        else
        if (propery.name == "NameOnCard") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                self.validate2 = false
                return self.validate2

            }
            
            let whitespace = CharacterSet.whitespaces
            
            let range = value.description.rangeOfCharacter(from: whitespace)
            
            // range will be nil if no whitespace is found
            if range != nil {
                
                let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                
                for index in 0 ..< fullNameArr.count
                {
                    let fistname = fullNameArr[index] // First
                    
                    let decimalCharacters = CharacterSet.decimalDigits
                    
                    let decimalRange1 = fistname.rangeOfCharacter(from: decimalCharacters, options: NSString.CompareOptions(), range: nil)
                    
                    if decimalRange1 != nil {
                        
                        dataSource2["NameOnCard"].errorMessage = "Name On Card is not valid"
                        self.validate2 = false
                        return self.validate2
                    }
                    
                }
                
            }
            else {
                
                dataSource2["NameOnCard"].errorMessage = "Name On Card is not valid"
                self.validate2 = false
                return self.validate2
            }

            
            self.validate2 = true


        }
        else
        if (propery.name == "CardNumber") {
            
            let value = (propery.valueCandidate as AnyObject).description
            
            if ((value?.length)! <= 0)
            {
                self.validate3 = false
                return self.validate3

            }
            else
            {
                
                let v = CreditCardValidator()
                
                if v.validate(string: value!){
                    
                    self.validate3 = true
                    
                }
                else
                {
                    
                    self.dataSource2["CardNumber"].errorMessage = "Card Number is not valid"
                    self.validate3 = false
                    
                }
                
                return self.validate3

            }
            
        }
        else
        if (propery.name == "Cvv") {
            
            let value = (propery.valueCandidate as AnyObject).description
            if ((value?.length)! <= 0)
            {
                self.validate4 = false
                return self.validate4
            }
            
            if (value?.length < 3 || value?.length > 3 )
            {
                dataSource2["Cvv"].errorMessage = "CVV is not valid"

                self.validate4 = false
                return self.validate4
            }
            
            self.validate4 = true
            
        }
        else
            if (propery.name == "ExpiryMonth") {
                
                
                let monthValue = propery.valueCandidate as! Int
                let yearValue = self.dataSource2["ExpiryYear"].valueCandidate as! Int
                
                let date = Date()
                let calendar = Calendar.current
                let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
                
                let currentYear =  components.year
                let currentMonth = components.month

                if(yearValue < currentYear){
                    dataSource2["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                    self.validate5 = false
                    return self.validate5
                }
                else if(yearValue == currentYear)
                {
                    if(monthValue < currentMonth){
                        dataSource2["ExpiryMonth"].errorMessage = "Expiry month must be later than this month"
                        self.validate5 = false
                        return self.validate5
                    }
                    else if(monthValue > 12)
                    {
                        dataSource2["ExpiryMonth"].errorMessage = "Expiry Month is not valid"
                        self.validate5 = false
                        return self.validate5
                    }
                }
                else if(yearValue > currentYear)
                {
                    if(monthValue > 12)
                    {
                        dataSource2["ExpiryMonth"].errorMessage = "Expiry Month is not valid"
                        self.validate5 = false
                        return self.validate5
                    }
                }
                
                self.validate5 = true
        }
            else
                if (propery.name == "ExpiryYear") {
                    
                    let yearValue = propery.valueCandidate as! Int
                    
                    let date = Date()
                    let calendar = Calendar.current
                    let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
                    
                    let currentYear =  components.year
                    
                    if(yearValue < currentYear){
                        dataSource2["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                        dataSource2["ExpiryMonth"].errorMessage = ""

                        self.validate6 = false
                        return self.validate6
                    }
                    
                    self.validate6 = true


        }
        else
                    if (propery.name == "AccountName") {
                        
                        let value = propery.valueCandidate as! NSString
                        
                        if (value.length <= 0)
                        {
                            dataSource2["AccountName"].errorMessage = "Please enter Account Name"
                            self.validate7 = false
                            return self.validate7
                        }
                        
                        let whitespace = CharacterSet.whitespaces
                        
                        let range = value.description.rangeOfCharacter(from: whitespace)
                        
                        // range will be nil if no whitespace is found
                        if range != nil {
                            
                            let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                            
                            for index in 0 ..< fullNameArr.count
                            {
                                let fistname = fullNameArr[index] // First
                                
                                let decimalCharacters = CharacterSet.decimalDigits
                                
                                let decimalRange1 = fistname.rangeOfCharacter(from: decimalCharacters, options: NSString.CompareOptions(), range: nil)
                                
                                if decimalRange1 != nil {
                                    
                                    dataSource2["AccountName"].errorMessage = "Account Name is not valid"
                                    self.validate7 = false
                                    return self.validate7
                                }
                                
                            }
                            
                        }
                        else {
                            
                            dataSource2["AccountName"].errorMessage = "Account Name is not valid"
                            self.validate7 = false
                            return self.validate7
                        }
                        
                        self.validate7 = true
                    }
                    else
                        if (propery.name == "BSB1") {
                            
                            let value = propery.valueCandidate as! NSString
                            
                            if (value.length <= 0)
                            {
                                dataSource2["BSB1"].errorMessage = "Please enter BSB 1"
                                self.validate8 = false
                                return self.validate8
                            }
                            else
                                if (value.length > 3 || value.length < 3)
                                {
                                    dataSource2["BSB1"].errorMessage = "The BSB number 1 is not valid"
                                    self.validate8 = false
                                    return self.validate8
                            }
                            
                            self.validate8 = true
                            
                        }
                        else
                            if (propery.name == "BSB2") {
                                
                                let value = propery.valueCandidate as! NSString
                                
                                if (value.length <= 0)
                                {
                                    
                                    dataSource2["BSB2"].errorMessage = "Please enter BSB 1"
                                    self.validate9 = false
                                    return self.validate9
                                }
                                else
                                    if (value.length > 3 || value.length < 3)
                                    {
                                        dataSource2["BSB2"].errorMessage = "The BSB number 2 is not valid"
                                        self.validate9 = false
                                        return self.validate9
                                }
                                
                                self.validate9 = true
                            }
                            else
                                if (propery.name == "AccountNumber") {
                                    
                                    let value = propery.valueCandidate as! NSString
                                    
                                    if (value.length <= 0)
                                    {
                                        dataSource2["AccountNumber"].errorMessage = "Please enter Account Number"
                                        self.validate10 = false
                                        return self.validate10
                                    }
                                    else
                                        if (value.length > 15 || value.length < 5)
                                        {
                                            dataSource2["AccountNumber"].errorMessage = "Account Number should be from 5 to 15 numeric characters in length"
                                            self.validate10 = false
                                            return self.validate10
                                    }
                                    
                                    self.validate10 = true
                                    
                                }
        
        return true
    }

    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        view.showLoading()

        let cardObject = CardInfo()
        let bankObject = BankInfo()

        cardObject.PaymentMethod = self.dataSource2["PaymentMethod"].valueCandidate as! Int

        if(self.isProcesing){
            self.view.hideLoading();
            return
            
        }
        
        self.dataForm2.commit()
        self.dataForm2.commit()

        if(cardObject.PaymentMethod == 0){
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5 && self.validate6
        }
        else
        {
            self.isFormValidate = self.validate1 && self.validate7 && self.validate7 && self.validate9 && self.validate10
        }
        
        if(!self.isFormValidate){
            self.view.hideLoading();
            return
        }
        
        if(!self.sw_Agree.isOn){
            self.view.hideLoading();
            LocalStore.Alert(self.view, title: "Terms & Conditions", message: "Please agree to the Terms & Conditions to continue", indexPath: 0)
            return
        }
        
        cardObject.Amount       = (self.dataSource2["Amount"].valueCandidate as AnyObject).doubleValue
        
        if(cardObject.PaymentMethod == 0){

            cardObject.CardNumber   = self.dataSource2["CardNumber"].valueCandidate as! String
            cardObject.ExpiryMonth  = self.dataSource2["ExpiryMonth"].valueCandidate as! Int
            cardObject.ExpiryYear   = self.dataSource2["ExpiryYear"].valueCandidate as! Int
            cardObject.Cvv          = self.dataSource2["Cvv"].valueCandidate as! String
            cardObject.NameOnCard   = self.dataSource2["NameOnCard"].valueCandidate as! String
            cardObject.CardType     = self.dataSource2["CardType"].valueCandidate as! Int
        }
        else
        {
            
            bankObject.Amount           = (self.dataSource2["Amount"].valueCandidate as AnyObject).doubleValue
            bankObject.AccountNumber    = self.dataSource2["AccountNumber"].valueCandidate as! String
            bankObject.AccountName      = self.dataSource2["AccountName"].valueCandidate as! String
            bankObject.BSB1             = self.dataSource2["BSB1"].valueCandidate as! String
            bankObject.BSB2             = self.dataSource2["BSB2"].valueCandidate as! String
        }
        
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
                cardObject.DebtorPaymentInstallment = jsonString as String
                bankObject.DebtorPaymentInstallment = jsonString as String
            }

        }
        
        var PaymentType = 0
        
//        1: Pay In Full
//        2: Pay In 3 Part
//        3: Pay In Installment
//        4: Pay Other Amount
//        5: Pay Next Instalment


        if(cardObject.Amount == LocalStore.accessTotalOutstanding()){
            PaymentType = 1
            LocalStore.setMakePaymentInFull(true)
        }
        else
            if(LocalStore.accessMakePaymentIn3Part()){
                PaymentType = 2
            }
            else
                if(LocalStore.accessMakePaymentInstallment()){
                    PaymentType = 3
                }
                else
                    if(cardObject.Amount < LocalStore.accessTotalOutstanding()){
                        PaymentType = 4
                        LocalStore.setMakePaymentOtherAmount(true)
                    }
        
        self.isProcesing = true
        
        if(cardObject.PaymentMethod == 0){

            WebApiService.MakeCreditCardPayment(cardObject, PaymentType: PaymentType){ objectReturn in
        
                self.view.hideLoading();

                if let temp1 = objectReturn
                {
            
                    if(temp1.IsSuccess)
                    {
                        
                            WebApiService.sendActivityTracking("Make CC Payment")

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
                        
                        self.dataForm2.validationMode = TKDataFormValidationMode.immediate


                    }
                }
                else
                {
                    self.isProcesing = false

                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                    
                    self.dataForm2.validationMode = TKDataFormValidationMode.immediate

                }
            }
        }
        else
        {
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
                        
                        self.dataForm2.validationMode = TKDataFormValidationMode.immediate

                        
                    }
                }
                else
                {
                    self.isProcesing = false
                    
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                    
                    self.dataForm2.validationMode = TKDataFormValidationMode.immediate

                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUpdateDetail" {
            
            let controller = segue.destination as! UpdatePersonalInfoViewController
            controller.paymentReturn = self.paymentReturn
            
            let PaymentMethod = self.dataSource2["PaymentMethod"].valueCandidate as! Int

            
            if(PaymentMethod == 0){
                controller.screenComeForm = "CCPayment"
                controller.paymentMethod = 1

            }
            else
            {
                controller.screenComeForm = "DDPayment"
                controller.paymentMethod = 2
            }
        }
    }

}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}









