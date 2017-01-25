

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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdateBankAccountViewController.dismissKeyboard))
        
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
                        self.bankInfo = temp1.bank
                    }

                    
                    self.dataSource.sourceObject = self.bankInfo
                    
                    self.dataSource["Amount"].hidden = true
                    self.dataSource["BSB"].hidden = true
                    self.dataSource["DebtorPaymentInstallment"].hidden = true
                    
                    
                    self.dataSource["AccountName"].index = 0
                    
                    self.dataSource["BSB1"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["BSB1"].index = 1
                    self.dataSource["BSB1"].displayName = "BSB 1"
                    
                    self.dataSource["BSB2"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["BSB2"].index = 2
                    self.dataSource["BSB2"].displayName = "BSB 2"
                    
                    self.dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["AccountNumber"].index = 3
                    
                    
                    self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                    self.dataForm1.delegate = self
                    self.dataForm1.dataSource = self.dataSource
                    
                    self.dataForm1.backgroundColor = UIColor.white
                    self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
                    
                    self.dataForm1.commitMode = TKDataFormCommitMode.manual
                    self.dataForm1.validationMode = TKDataFormValidationMode.manual
                    
                    self.subView.addSubview(self.dataForm1)
                    
                
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
                    let fistname = fullNameArr[index] // First
                    
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
                        
                        dataSource["BSB2"].errorMessage = "Please entter BSB 2"
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
        
            
            self.dataForm1.commit()
            
            
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5
 
            if(!self.isFormValidate){
                
                return
            }
            
            self.view.showLoading();
            
            let paymentInfo = PaymentInfo()
            
            paymentInfo.bank.AccountName        = (self.dataSource["AccountName"].valueCandidate as AnyObject).description
            paymentInfo.bank.AccountNumber      = (self.dataSource["AccountNumber"].valueCandidate as AnyObject).description
            paymentInfo.bank.BSB                = (self.dataSource["BSB1"].valueCandidate as AnyObject).description + (self.dataSource["BSB2"].valueCandidate as AnyObject).description
            
            paymentInfo.RecType = "DD"
            
            WebApiService.SetPaymentInfo(paymentInfo){ objectReturn in
                
                self.view.hideLoading();
                
                if let temp1 = objectReturn
                {
                    
                    if(temp1.IsSuccess)
                    {
                        
                        WebApiService.sendActivityTracking("Update Bank Account")

                        self.performSegue(withIdentifier: "GoToNotice", sender: nil)
                        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "Your bank account has been updated successfully"
            
        }
    }

}
