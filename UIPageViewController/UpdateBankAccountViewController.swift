

import UIKit

class UpdateBankAccountViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var bankInfo = BankInfo()
    
    var dataForm1 = TKDataForm()
    
    var isFormValidate : Bool = true


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

                
                if(temp1.IsSuccess){
                    self.bankInfo = temp1.bank
                
                    self.dataSource.sourceObject = self.bankInfo
                
                    self.dataSource["Amount"].hidden = true
                    self.dataSource["Bsb1"].hidden = true
                    self.dataSource["Bsb2"].hidden = true

                
                    self.dataSource["AmountName"].index = 0
                
                    self.dataSource["Bsb"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["Bsb"].index = 1

                    self.dataSource["AccountNumber"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["AccountNumber"].index = 2
                

                    self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                    self.dataForm1.dataSource = self.dataSource
                    self.dataForm1.commitMode = TKDataFormCommitMode.Manual
                    self.dataForm1.validationMode = TKDataFormValidationMode.Manual
                
                
                    self.dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
                
                    self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                
                    self.subView.addSubview(self.dataForm1)
                }
                else
                {
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: temp1.Errors, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                        UIAlertAction in
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }
                    
                    alert.addAction(okAction)
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                    
                
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    
                    self.navigationController?.popViewControllerAnimated(true)
                    
                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
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
        self.isFormValidate = true
        

            if (propery.name == "AccountName") {
                
                let value = propery.valueCandidate as! NSString
                
                if (value.length <= 0)
                {
                    dataSource["AccountName"].errorMessage = "Please input Account Name"
                    self.isFormValidate = false
                }
                
            }
            else
                if (propery.name == "Bsb") {
                    
                    let value = propery.valueCandidate as! NSString
                    
                    if (value.length <= 0)
                    {
                        self.isFormValidate = false
                    }
                    else
                        if (value.length > 6)
                        {
                            dataSource["Bsb1"].errorMessage = "Bsb is maximum 6 number in lenght"
                            self.isFormValidate = false
                    }
                    
                }
                else
                        if (propery.name == "AccountNumber") {
                            
                            let value = propery.valueCandidate as! NSString
                            
                            if (value.length <= 0)
                            {
                                dataSource["AccountNumber"].errorMessage = "Please input Account Number"
                                self.isFormValidate = false
                            }
                            
        }
        
        return isFormValidate
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        self.dataForm1.commit()
        
        if(!self.isFormValidate){
            
            return
        }
        
        self.view.showLoading();
        
        let paymentInfo = PaymentInfo()
        
        paymentInfo.bank.AccountName        = self.dataSource["AccountName"].valueCandidate.description
        paymentInfo.bank.AccountNumber      = self.dataSource["AccountNumber"].valueCandidate.description
        paymentInfo.bank.Bsb                = self.dataSource["Bsb"].valueCandidate.description
        
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
                    
                    // create the alert
                    let alert = SCLAlertView()
                    alert.hideWhenBackgroundViewIsTapped = true
                    alert.showError("Error", subTitle:temp1.Errors)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your bank account has been updated successfully."
            
        }
    }

}
