

import UIKit

class UpdateBankAccountViewController: TKDataFormViewController {
    
    @IBOutlet weak var subView: UIView!
    
    let dataFormEntityDataSource = TKDataFormEntityDataSource()
    
    var bankInfo = BankInfo()
    
    
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

                self.bankInfo = temp1.bank
                
                self.dataFormEntityDataSource.sourceObject = self.bankInfo
                
                self.dataFormEntityDataSource["Amount"].hidden = true
                
                self.dataFormEntityDataSource["Bsb"].editorClass = TKDataFormNumberEditor.self
                //
                self.dataFormEntityDataSource["AccountNumber"].editorClass = TKDataFormNumberEditor.self
                //
                
                
                self.dataForm.dataSource = self.dataFormEntityDataSource
                self.dataForm.commitMode = TKDataFormCommitMode.OnLostFocus
                self.dataForm.validationMode = TKDataFormValidationMode.Manual
                
                
                self.dataForm.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
                
                self.dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                
                self.subView.addSubview(self.dataForm)
                
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
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
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
//        if property.name == "Amount" {
//            (editor.editor as! UITextField).hidden = true;
//            
//            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
//            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
//            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
//            editor.style.editorOffset = UIOffsetMake(10, 0)
//        }
    }
    
    override func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {

        return true
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        //self.dataForm.reloadData()
        
        self.view.showLoading();
        
        var paymentInfo = PaymentInfo()
        
        paymentInfo.bank.AccountName        = self.dataFormEntityDataSource["AccountName"].valueCandidate.description
        paymentInfo.bank.AccountNumber      = self.dataFormEntityDataSource["AccountNumber"].valueCandidate.description
        paymentInfo.bank.Bsb                = self.dataFormEntityDataSource["Bsb"].valueCandidate.description
        
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
                    let alert = UIAlertController(title: "Error", message: temp1.Errors, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
