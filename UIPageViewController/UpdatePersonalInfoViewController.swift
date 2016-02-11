

import UIKit

class UpdatePersonalInfoViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = PaymentInfo()
    
    var alignmentMode: String = ""
    var dataForm1  = TKDataForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        alignmentMode = "Top"
        
        // Do any additional setup after loading the view.
        loadData()
        
        self.dataForm1.reloadData()
        
    }
    
//    func prepareTopAlignment () {
//
//        self.dataForm1.reloadData()
//    }
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPersonalInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                self.paymentInfo = temp1
                
                self.dataSource.sourceObject = self.paymentInfo.personalInfo
                
                self.dataSource["StreetAddress"].editorClass = TKDataFormTextFieldEditor.self
                self.dataSource["MailAddress"].editorClass = TKDataFormTextFieldEditor.self
                
                self.dataSource.addGroupWithName("Address", propertyNames: ["StreetAddress", "MailAddress"])
                self.dataSource.addGroupWithName("Phone", propertyNames: ["HomePhone", "WorkPhone", "MobilePhone"])
                
                self.dataSource["HomePhone"].editorClass = TKDataFormPhoneEditor.self
                self.dataSource["WorkPhone"].editorClass = TKDataFormPhoneEditor.self
                self.dataSource["MobilePhone"].editorClass = TKDataFormPhoneEditor.self

                
                self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                
                self.dataForm1.delegate = self
                self.dataForm1.dataSource = self.dataSource
                self.dataForm1.backgroundColor = UIColor.whiteColor()
                self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
                
                self.subView.addSubview(self.dataForm1)
 
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
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
        property.hintText = property.displayName
        if alignmentMode == "Top" {
            self.performTopAlignmentSettingsForEditor(editor, property: property)
        }
    }
    
    func dataForm(dataForm: TKDataForm, didEditProperty property: TKEntityProperty) {
    }
    
    func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        return true
    }
    
    func dataForm(dataForm: TKDataForm, didSelectEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        let borderColor = UIColor(red:0.000, green:0.478, blue:1.000, alpha:1.00)
        var layer = editor.editor.layer
        
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
        }
        
        let currentBorderColor = UIColor(CGColor: layer.borderColor!)
        layer.borderColor = borderColor.CGColor
        let animate = CABasicAnimation(keyPath: "borderColor")
        animate.fromValue = currentBorderColor
        animate.toValue = borderColor
        animate.duration = 0.4
        layer.addAnimation(animate, forKey: "borderColor")
    }
    
    func dataForm(dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, atIndex editorIndex: UInt) -> CGFloat {
        if alignmentMode == "Top" {
            if gorupIndex == 0 && editorIndex == 2 {
                return 20
            }
            
            return 65
        }
        
        return 44
    }

    func dataForm(dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        //self.dataForm.reloadData()
        
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
    
    func performTopAlignmentSettingsForEditor(editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
        editor.textLabel.font = UIFont.systemFontOfSize(15)
        editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right)
        

        let gridLayout = editor.gridLayout
        let editorDef = gridLayout.definitionForView(editor.editor)
        editorDef?.row = 1
        editorDef?.column = 1
        
            
        let feedbackLabelDef = gridLayout.definitionForView(editor.feedbackLabel)
        feedbackLabelDef.row = 2
        feedbackLabelDef.column = 1
        feedbackLabelDef.columnSpan = 1
            
        self.setEditorStyle(editor)

    }
    
    func setEditorStyle(editor: TKDataFormEditor) {
        if editor.selected {
            return;
        }
        
        var layer = editor.editor.layer

        if editor.isKindOfClass(TKDataFormTextFieldEditor) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
