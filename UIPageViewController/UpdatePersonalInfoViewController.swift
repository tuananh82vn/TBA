

import UIKit

class UpdatePersonalInfoViewController: TKDataFormViewController {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = PaymentInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        dataSource.sourceObject = self.paymentInfo.personalInfo
        
        
        let dataForm = TKDataForm(frame: self.subView.bounds)
        dataForm.delegate = self
        dataForm.dataSource = dataSource
        dataForm.backgroundColor = UIColor.whiteColor()
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        self.subView.addSubview(dataForm)
        
        // Do any additional setup after loading the view.
        loadData()
        
    }
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPersonalInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                self.paymentInfo = temp1
                
                self.dataForm.reloadData()
                
                self.dataForm.update()
                
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
        
        if property.name == "Amount" {
            (editor.editor as! UITextField).hidden = true;
            
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
            editor.style.editorOffset = UIOffsetMake(10, 0)
        }
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
        
        var personalInfo = PersonalInfo()
        
        personalInfo.StreetAddress          = self.dataSource["StreetAddress"].valueCandidate as! String
        personalInfo.MailAddress            = self.dataSource["MailAddress"].valueCandidate as! String
        personalInfo.HomePhone              = self.dataSource["HomePhone"].valueCandidate as! String
        personalInfo.MobilePhone            = self.dataSource["MobilePhone"].valueCandidate as! String
        personalInfo.WorkPhone              = self.dataSource["WorkPhone"].valueCandidate as! String

        
        WebApiService.SetPersonalInfo(personalInfo){ objectReturn in
            
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
