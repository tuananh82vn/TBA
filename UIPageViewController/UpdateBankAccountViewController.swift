

import UIKit

class UpdateBankAccountViewController: TKDataFormViewController {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = BankInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
      
//        dataSource.sourceObject = self.paymentInfo
        

        
        // Do any additional setup after loading the view.
        loadData()
        
    }
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPaymentInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                self.paymentInfo = temp1.bank
                
                self.dataSource.sourceObject = self.paymentInfo
                
                self.dataSource["Amount"].hidden = true
                
                self.dataSource["Bsb"].editorClass = TKDataFormDecimalEditor.self
                self.dataSource["AccountNumber"].editorClass = TKDataFormDecimalEditor.self
                
                self.dataSource["AccountName"].hintText = "Account Name"
                
                let dataForm = TKDataForm(frame: self.subView.bounds)
                dataForm.delegate = self
                dataForm.dataSource = self.dataSource
                dataForm.backgroundColor = UIColor.whiteColor()
                dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                
                self.subView.addSubview(dataForm)
                
                self.dataForm.reloadData()    
                
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
        
        paymentInfo.bank.AccountName        = self.dataSource["AccountName"].valueCandidate as! String
        paymentInfo.bank.AccountNumber      = self.dataSource["AccountNumber"].valueCandidate as! String
        paymentInfo.bank.Bsb               = self.dataSource["Bsb"].valueCandidate as! String
        paymentInfo.RecType = "DD"
        
        WebApiService.SetPaymentInfo(paymentInfo){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                    // create the alert
                    let alert = UIAlertController(title: "Done", message: "Update done", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
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
