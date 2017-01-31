//
//  MakePaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
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

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

class MakeCreditPaymentViewController: UIViewController , TKDataFormDelegate , UITextViewDelegate {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sw_Agree: UISwitch!
    
    let dataSource = TKDataFormEntityDataSource()
    let cardInfo = CardInfo()
    var paymentReturn = PaymentReturnModel()
    

    var dataForm1 = TKDataForm()
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true
    
    var isProcesing : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        let phoneUrl = NSURL(string: "tel:+0404221082")!
        let attributes = [NSLinkAttributeName: phoneUrl]
        let attributedString = NSAttributedString(string: "Credit Card Terms & Conditions", attributes: attributes)

        
        textView.attributedText = NSAttributedString(string: "I acknowledge RecoveriesCorp will use my Credit Card details for this payment arrangement. I have read and agree to the ") + attributedString
        
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.layoutManager.allowsNonContiguousLayout = false;
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MakeCreditPaymentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if(LocalStore.accessMakePaymentInFull()){
            cardInfo.Amount = LocalStore.accessTotalOutstanding()
        }
        
        if(LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()){
            cardInfo.Amount = LocalStore.accessFirstAmountOfInstalment()
        }
        
        dataSource.sourceObject = cardInfo
        
        dataSource["Amount"].hintText = "Amount To Pay"
        dataSource["Amount"].editorClass = TKDataFormDecimalEditor.self
        
        
        if(LocalStore.accessMakePaymentInFull() || LocalStore.accessMakePaymentIn3Part() || LocalStore.accessMakePaymentInstallment()){
            dataSource["Amount"].readOnly = true
        }

        
        dataSource["CardType"].valuesProvider = [ "Visa", "Master" ]
        

        dataSource["NameOnCard"].hintText = "Name On Card"
        dataSource["NameOnCard"].errorMessage = "Please enter name"

        dataSource["CardNumber"].hintText = "Card Number"
        dataSource["CardNumber"].editorClass = TKDataFormPhoneEditor.self
        dataSource["CardNumber"].errorMessage = "Please enter card number"

        dataSource["Cvv"].hintText = "Card Security Code"
        dataSource["Cvv"].editorClass = TKDataFormPhoneEditor.self
        dataSource["Cvv"].errorMessage = "Please enter CVV"
        dataSource["Cvv"].displayName = "CVV"

        dataSource["DebtorPaymentInstallment"].hidden = true
        dataSource["ExpiryDate"].hidden = true

        
        dataSource["ExpiryMonth"].editorClass = TKDataFormNumberEditor.self
        dataSource["ExpiryYear"].editorClass = TKDataFormNumberEditor.self

        
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
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
        /* perform your own custom actions here */
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "CreditCardTCViewController") as! CreditCardTCViewController
        
        self.navigationController!.pushViewController(viewController, animated: true)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        if property.name == "Cvv" {
            (editor.editor as! UITextField).isSecureTextEntry = true;
        }
    }
    
    func dataForm(_ dataForm: TKDataForm, didEdit property: TKEntityProperty) {
        
    }
    
    func dataForm(_ dataForm: TKDataForm, update groupView: TKEntityPropertyGroupView, forGroupAt groupIndex: UInt) {
        
    }
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        

        if (propery.name == "Amount") {
            
            let value = (propery.valueCandidate as AnyObject).description
            if ((value?.length)! <= 0)
            {
                dataSource["Amount"].errorMessage = "Please input amount"
                self.validate1 = false
                return self.validate1
            }

            let floatValue = value?.floatValue
            let maxValue : Float  = 10.00

            if (floatValue! <= maxValue)
            {
                dataSource["Amount"].errorMessage = "Payment amount is less than the minimum required"
                self.validate1 = false
                return self.validate1

            }
            else
                if (Double((floatValue?.description)!) > LocalStore.accessTotalOutstanding())
                {
                    dataSource["Amount"].errorMessage = "Payment amount must be less than the outstanding amount"
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
            if let test = range {
                
                let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                
                for index in 0 ..< fullNameArr.count
                {
                    var fistname = fullNameArr[index] // First
                    
                    let decimalCharacters = CharacterSet.decimalDigits
                    
                    let decimalRange1 = fistname.rangeOfCharacter(from: decimalCharacters, options: NSString.CompareOptions(), range: nil)
                    
                    if decimalRange1 != nil {
                        
                        dataSource["NameOnCard"].errorMessage = "Name On Card is not valid"
                        self.validate2 = false
                        return self.validate2
                    }
                    
                }
                
            }
            else {
                
                dataSource["NameOnCard"].errorMessage = "Name On Card is not valid"
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
                    
                    self.dataSource["CardNumber"].errorMessage = "Card Number is not valid"
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
                dataSource["Cvv"].errorMessage = "CVV is not valid"

                self.validate4 = false
                return self.validate4
            }
            
            self.validate4 = true
            
        }
        else
            if (propery.name == "ExpiryMonth") {
                
                
                let monthValue = propery.valueCandidate as! Int
                let yearValue = self.dataSource["ExpiryYear"].valueCandidate as! Int
                
                let date = Date()
                let calendar = Calendar.current
                let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
                
                let currentYear =  components.year
                let currentMonth = components.month

                if(yearValue < currentYear){
                    dataSource["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                    self.validate5 = false
                    return self.validate5
                }
                else if(yearValue == currentYear)
                {
                    if(monthValue < currentMonth){
                        dataSource["ExpiryMonth"].errorMessage = "Expiry month must be later than this month"
                        self.validate5 = false
                        return self.validate5
                    }
                    else if(monthValue > 12)
                    {
                        dataSource["ExpiryMonth"].errorMessage = "Expiry Month is not valid"
                        self.validate5 = false
                        return self.validate5
                    }
                }
                else if(yearValue > currentYear)
                {
                    if(monthValue > 12)
                    {
                        dataSource["ExpiryMonth"].errorMessage = "Expiry Month is not valid"
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
                        dataSource["ExpiryYear"].errorMessage = "Expire year must be later than or equal this year"
                        dataSource["ExpiryMonth"].errorMessage = ""

                        self.validate6 = false
                        return self.validate6
                    }
                    
                    self.validate6 = true


        }
        return true
    }

    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        if(self.isProcesing){
            return
        }
        
        self.dataForm1.commit()

        self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5 && self.validate6
        
        if(!self.isFormValidate){
            
            return
        }
        
        if(!self.sw_Agree.isOn){
            LocalStore.Alert(self.view, title: "Terms & Conditions", message: "Please agree to the Terms & Conditions to continue", indexPath: 0)
            return
        }
        
        
        view.showLoading()
        
        let cardObject = CardInfo()
        
        cardObject.Amount       = (self.dataSource["Amount"].valueCandidate as AnyObject).doubleValue
        cardObject.CardNumber   = self.dataSource["CardNumber"].valueCandidate as! String
        
        cardObject.ExpiryMonth     = self.dataSource["ExpiryMonth"].valueCandidate as! Int
        cardObject.ExpiryYear     = self.dataSource["ExpiryYear"].valueCandidate as! Int

        cardObject.Cvv          = self.dataSource["Cvv"].valueCandidate as! String
        cardObject.NameOnCard   = self.dataSource["NameOnCard"].valueCandidate as! String
        cardObject.CardType     = self.dataSource["CardType"].valueCandidate as! Int
        
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
        
        WebApiService.MakeCreditCardPayment(cardObject, PaymentType: PaymentType){ objectReturn in
        
            self.view.hideLoading();

            if let temp1 = objectReturn
            {
        
                if(temp1.IsSuccess)
                {
                        WebApiService.sendActivityTracking("Make CC Payment")

                        self.paymentReturn = temp1
                    
                        self.performSegue(withIdentifier: "GoToSummary", sender: nil)
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
        if segue.identifier == "GoToSummary" {
            
            let controller = segue.destination as! SummaryViewController
            controller.paymentReturn = self.paymentReturn
            controller.paymentMethod = 1
        }
    }

}

class DateMonthEditor: TKDataFormDatePickerEditor {
    
    
    override init(property: TKEntityProperty, owner: TKDataForm) {
        super.init(property: property, owner: owner)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
}





