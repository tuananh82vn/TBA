

import UIKit

class UpdateBankAccountViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var bankInfo = BankInfo()
    
    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true

    var validate5 : Bool = true

    @IBOutlet weak var bt_Continue: UIButton!
    
    var isError : Bool = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)

        initData()
        
    }
    
    func initData(){
        
        self.view.showLoading()
        
        WebApiService.GetPaymentInfo(){ objectReturn in
            
            self.view.hideLoading();
            
                if let temp1 = objectReturn
                {

                
                    if(temp1.IsSuccess)
                    {
                        
                        self.isError = false
                        self.bt_Continue.setTitle("Continue", forState: UIControlState.Normal)
                        
                        self.bankInfo = temp1.bank
                        
                        self.dataSource.sourceObject = self.bankInfo
                        
                        self.dataSource["Amount"].hidden = true
                        self.dataSource["Bsb"].hidden = true
                        self.dataSource["DebtorPaymentInstallment"].hidden = true

                        
                        self.dataSource["AccountName"].index = 0
                        
                        self.dataSource["Bsb1"].editorClass = TKDataFormPhoneEditor.self
                        self.dataSource["Bsb1"].index = 1
                        
                        self.dataSource["Bsb2"].editorClass = TKDataFormPhoneEditor.self
                        self.dataSource["Bsb2"].index = 2
                        
                        self.dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
                        self.dataSource["AccountNumber"].index = 3
                        
                        
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
                        self.isError = true
                        self.bt_Continue.setTitle("Make a Payment", forState: UIControlState.Normal)
                    }
                    
                
            }
            else
            {

                LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)

            }
        }

    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
    }
    
    func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        

        if (propery.name == "AccountName") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["AccountName"].errorMessage = "Please enter 'Account Name'"
                self.validate2 = false
                return self.validate2
            }
            
            let whitespace = NSCharacterSet.whitespaceCharacterSet()
            
            let range = value.description.rangeOfCharacterFromSet(whitespace)
            
            // range will be nil if no whitespace is found
            if let test = range {
                
                let fullNameArr = value.description.characters.split{$0 == " "}.map(String.init)
                
                for (var index = 0; index < fullNameArr.count; index++)
                {
                    var fistname = fullNameArr[index] // First
                    
                    let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
                    
                    let decimalRange1 = fistname.rangeOfCharacterFromSet(decimalCharacters, options: NSStringCompareOptions(), range: nil)
                    
                    if decimalRange1 != nil {
                        
                        dataSource["AccountName"].errorMessage = "Invalid 'Account Name'"
                        self.validate2 = false
                        return self.validate2
                    }
                    
                }
                
            }
            else {
                
                dataSource["AccountName"].errorMessage = "Invalid 'Account Name'"
                self.validate2 = false
                return self.validate2
            }
            
            self.validate2 = true
        }
        else
            if (propery.name == "Bsb1") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["Bsb1"].errorMessage = "Please input Bsb 1"
                    self.validate3 = false
                    return self.validate3
                }
                else
                    if (value.length > 3 || value.length < 3)
                    {
                        dataSource["Bsb1"].errorMessage = "The 'BSB' number 1 is invalid"
                        self.validate3 = false
                        return self.validate3
                }
                
                self.validate3 = true
                
            }
            else
                if (propery.name == "Bsb2") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        
                        dataSource["Bsb2"].errorMessage = "Please input Bsb 2"
                        self.validate4 = false
                        return self.validate4
                    }
                    else
                        if (value.length > 3 || value.length < 3)
                        {
                            dataSource["Bsb2"].errorMessage = "The 'BSB' number 2 is invalid"
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
                            dataSource["AccountNumber"].errorMessage = "Please enter 'Account Number'"
                            self.validate5 = false
                            return self.validate5
                        }
                        else
                            if (value.length > 15 || value.length < 5)
                            {
                                dataSource["AccountNumber"].errorMessage = "'Account Number' should be from 5 to 15 numeric characters in length"
                                self.validate5 = false
                                return self.validate5
                        }
                        
                        self.validate5 = true

        }
        
        return true
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        if(!self.isError){
            
            self.dataForm1.commit()
            
            
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5
 
            if(!self.isFormValidate){
                
                return
            }
            
            self.view.showLoading();
            
            let paymentInfo = PaymentInfo()
            
            paymentInfo.bank.AccountName        = self.dataSource["AccountName"].valueCandidate.description
            paymentInfo.bank.AccountNumber      = self.dataSource["AccountNumber"].valueCandidate.description
            paymentInfo.bank.Bsb                = self.dataSource["Bsb1"].valueCandidate.description + self.dataSource["Bsb2"].valueCandidate.description
            
            paymentInfo.RecType = "DD"
            
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
        else
        {
            
            SetPayment.SetPayment(4)
            
            self.performSegueWithIdentifier("GoToCreditCard", sender: nil)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your bank account has been updated successfully."
            
        }
    }

}
