//
//  RequestCallbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 10/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class RequestCallbackViewController: TKDataFormViewController {

    let dataSource = TKDataFormEntityDataSource()
    
    let callbackForm = RequestCallBackForm()

    let btn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        dataSource.sourceObject = callbackForm
        
        let name = dataSource["name"]
        name.hintText = "Name"
        name.errorMessage = "Please fill in your name"
        name.image = UIImage(named: "guest-name")
        
        let phone = dataSource["phone"]
        phone.hintText = "Phone"
        phone.image = UIImage(named: "phone")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "h:mm a";
        dataSource["timefrom"].formatter = formatter
        dataSource["timeto"].formatter = formatter
        
        dataSource["date"].image = UIImage(named: "calendar-1")
        dataSource["date"].hintText = "Date"
        
        dataSource["timefrom"].image = UIImage(named: "time")
        dataSource["timeto"].image = UIImage(named: "time")

        dataSource["timefrom"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["timefrom"].hintText = "From"
        dataSource["timeto"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["timeto"].hintText = "To"
        
        dataSource["phone"].editorClass = CallEditor.self
        
        let notes = dataSource["notes"]
        notes.hintText = "Notes"
        notes.image = UIImage(named: "notes")
        
        self.dataForm.dataSource = dataSource
        self.dataForm.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 66)
        self.dataForm.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)

        btn.frame = CGRect(x: 0, y: self.dataForm.frame.size.height, width: self.view.bounds.size.width, height: 66)
        btn.setTitle("Request", forState: .Normal)
        btn.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0), forState: .Normal)
        btn.addTarget(self, action: "request", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btn.frame = CGRect(x: 0, y: self.dataForm.frame.size.height, width: self.view.bounds.size.width, height: 66)
    }
    
    func request() {
        let alert = TKAlert()
        
        alert.style.cornerRadius = 3;
        alert.title = "Request";
        alert.message = "Done";
        
        alert.addActionWithTitle("OK") { (TKAlert alert, TKAlertAction action) -> Bool in
            return true
        }
        
        alert.show(true)
    }
    
    //MARK:- TKDataFormDelegate
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if propery.name == "name" {
            return (propery.valueCandidate as! NSString).length > 0
        }
        return true
    }
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
        editor.style.textLabelOffset = UIOffsetMake(10, 0)
        editor.style.separatorLeadingSpace = 40
        editor.style.accessoryArrowStroke = TKStroke(color: UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0))
        
        if ["date", "timefrom", "timeto", "name", "phone"].contains(property.name) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
            editor.style.editorOffset = UIOffsetMake(10, 0)
        }
        
        
        if property.name == "name" {
            editor.style.feedbackLabelOffset = UIOffsetMake(10, 0)
            editor.feedbackLabel.font = UIFont(name: "Verdana-Italic", size: 10)
        }
        

    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.titleView.titleLabel.textColor = UIColor.lightGrayColor()
        groupView.titleView.titleLabel.font = UIFont.systemFontOfSize(13)
        groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0)
        if groupIndex == 1 {
            groupView.editorsContainer.backgroundColor = UIColor.clearColor()
        }
    }




}

import UIKit

class RequestCallBackForm: NSObject {
    
    var name = ""
    var phone = ""
    var date = NSDate()
    var timefrom = NSDate()
    var timeto = NSDate()
    var notes = ""

}

class CallEditor: TKDataFormPhoneEditor {
    
    let actionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        actionButton.setTitle("Enter your number", forState: UIControlState.Normal)
        actionButton.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.233, alpha: 1.0), forState: UIControlState.Normal)
        self.addSubview(actionButton)
        self.gridLayout.addArrangedView(actionButton)
        let btnDef = self.gridLayout.definitionForView(actionButton)
        btnDef.row = 0
        btnDef.column = 3
        self.gridLayout.setWidth(actionButton.sizeThatFits(CGSizeZero).width, forColumn: 3)
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
}

class TimeEditor: TKDataFormTimePickerEditor {
    
    let actionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        actionButton.setTitle("From", forState: UIControlState.Normal)
        actionButton.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.233, alpha: 1.0), forState: UIControlState.Normal)
        self.addSubview(actionButton)
        self.gridLayout.addArrangedView(actionButton)
        let btnDef = self.gridLayout.definitionForView(actionButton)
        btnDef.row = 0
        btnDef.column = 3
        self.gridLayout.setWidth(actionButton.sizeThatFits(CGSizeZero).width, forColumn: 3)
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
}

