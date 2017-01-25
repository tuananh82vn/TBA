

import UIKit

class UpdatePersonalInfoViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = PaymentInfo()
    
    var alignmentMode: String = ""
    
    var dataForm1  = TKDataForm()
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var isError : Bool = false

    
    @IBOutlet weak var bt_Continue: UIButton!
    
    var isFormValidate : Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdatePersonalInfoViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alignmentMode = "Top"
        
        // Do any additional setup after loading the view.
        loadData()
        
        self.dataForm1.reloadData()
        
    }
    
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPersonalInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                
                    self.paymentInfo = temp1
                    
                    self.dataSource.sourceObject = self.paymentInfo.personalInfo
                    
                    self.dataSource["StreetAddress"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailAddress"].editorClass = TKDataFormTextFieldEditor.self
                    
                    self.dataSource.addGroup(withName: "Address", propertyNames: ["StreetAddress", "MailAddress"])
                    self.dataSource.addGroup(withName: "Phone", propertyNames: ["HomePhone", "WorkPhone", "MobilePhone"])
                    
                    self.dataSource["HomePhone"].editorClass = TKDataFormPhoneEditor.self
                    self.dataSource["HomePhone"].hintText = "XX XXXX XXXX"
                    
                    self.dataSource["WorkPhone"].editorClass = TKDataFormPhoneEditor.self
                    
                    
                    self.dataSource["MobilePhone"].editorClass = MyPhoneEditor.self
                    self.dataSource["MobilePhone"].hintText = "04XX XXX XXX"
                    
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
                    LocalStore.Alert(self.view, title: "Error", message: temp1.Errors, indexPath: 0)
                    self.bt_Continue.setTitle("Finish", for: UIControlState())
                    self.isError = true

                }
 
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        
        property.hintText = property.displayName
        if alignmentMode == "Top" {
            self.performTopAlignmentSettingsForEditor(editor, property: property)
        }
    }
    
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if (propery.name == "MobilePhone") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["MobilePhone"].errorMessage = "Please enter 'Mobile Phone'"
                self.validate1 = false
                return self.validate1
            }

        }
        return true
    }
    
    
    func dataForm(_ dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, at editorIndex: UInt) -> CGFloat {

        return 65
    
    }

    func dataForm(_ dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        
        if(!self.isError)
        {
            self.dataForm1.commit()
            
            
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5
            
            if(!self.isFormValidate){
                
                return
            }
            
            
            self.view.showLoading();
            
            let personalInfo = PersonalInfo()
            
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
                        WebApiService.sendActivityTracking("Update Personal Info")

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
        else
        {
            
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    func performTopAlignmentSettingsForEditor(_ editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
//        editor.textLabel.font = UIFont.systemFontOfSize(15)
        editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right)
        

        let gridLayout = editor.gridLayout
        let editorDef = gridLayout.definition(for: editor.editor)
        editorDef?.row = 1
        editorDef?.column = 1
        
            
        let feedbackLabelDef = gridLayout.definition(for: editor.feedbackLabel)
        feedbackLabelDef?.row = 2
        feedbackLabelDef?.column = 1
        feedbackLabelDef?.columnSpan = 1
            
        self.setEditorStyle(editor)

    }
    
    func setEditorStyle(_ editor: TKDataFormEditor) {
        
        var layer = editor.editor.layer

        if editor.isKind(of: TKDataFormTextFieldEditor.self) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        

        
        layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "Your personal information has been updated successfully"
            
        }
    }
    
}
