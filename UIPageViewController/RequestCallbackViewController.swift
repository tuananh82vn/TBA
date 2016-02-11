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
    
    let requestCallBack = RequestCallBack()


    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        dataSource.sourceObject = requestCallBack
        
        
        
        dataSource["Name"].hintText = "Name"
        dataSource["Name"].errorMessage = "Please fill in your name"
        dataSource["Name"].image = UIImage(named: "guest-name")
        
        dataSource["Phone"].hintText = "Number"
        dataSource["Phone"].errorMessage = "Please fill in your number"
        dataSource["Phone"].image = UIImage(named: "phone")
        dataSource["Phone"].editorClass = TKDataFormPhoneEditor.self
        

        dataSource["Date"].image = UIImage(named: "calendar-1")
        dataSource["Date"].hintText = "Date"
        

        let TimeFormatter = NSDateFormatter()
        TimeFormatter.dateFormat = "h:mm a";
        

        dataSource["TimeFrom"].image = UIImage(named: "time")
        dataSource["TimeFrom"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeFrom"].hintText = "From"
        dataSource["TimeFrom"].formatter = TimeFormatter

        
        dataSource["TimeTo"].image = UIImage(named: "time")
        dataSource["TimeTo"].editorClass = TKDataFormTimePickerEditor.self
        dataSource["TimeTo"].hintText = "To"
        dataSource["TimeTo"].formatter = TimeFormatter


        dataSource["Notes"].hintText = "Notes"
        dataSource["Notes"].image = UIImage(named: "notes")
        
        
        
        self.dataForm.dataSource = dataSource
        self.dataForm.commitMode = TKDataFormCommitMode.OnLostFocus
        self.dataForm.validationMode = TKDataFormValidationMode.Manual


        self.dataForm.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)

        self.subView.addSubview(dataForm)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if propery.name == "Name" {
            return (propery.valueCandidate as! NSString).length > 0
        }
        if propery.name == "Phone" {
            return (propery.valueCandidate as! NSString).length > 0
        }
        return propery.isValid
    }
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
//        editor.style.textLabelOffset = UIOffsetMake(10, 0)
//        editor.style.separatorLeadingSpace = 40
//        editor.style.accessoryArrowStroke = TKStroke(color: UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0))
//        
//        if ["Date", "Name", "Phone"].contains(property.name) {
//            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
//            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
//            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
//            editor.style.editorOffset = UIOffsetMake(10, 0)
//        }
//        
//        
//        if property.name == "Name" {
//            editor.style.feedbackLabelOffset = UIOffsetMake(10, 0)
//            editor.feedbackLabel.font = UIFont(name: "Verdana-Italic", size: 10)
//        }
//        
//        if property.name == "Phone" {
//            editor.style.feedbackLabelOffset = UIOffsetMake(10, 0)
//            editor.feedbackLabel.font = UIFont(name: "Verdana-Italic", size: 10)
//        }
        

    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
//        groupView.titleView.titleLabel.textColor = UIColor.lightGrayColor()
//        groupView.titleView.titleLabel.font = UIFont.systemFontOfSize(13)
//        groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0)
//        if groupIndex == 1 {
//            groupView.editorsContainer.backgroundColor = UIColor.clearColor()
//        }
    }


    @IBAction func btContinue_Clicked(sender: AnyObject) {
        
        
        view.showLoading()
        
        var requestObject = RequestCallBack()
        
        requestObject.Notes         = self.dataSource["Notes"].valueCandidate as! String
        requestObject.Phone         = self.dataSource["Phone"].valueCandidate as! String
        requestObject.Name          = self.dataSource["Name"].valueCandidate as! String
        requestObject.Date          = self.dataSource["Date"].valueCandidate as! NSDate
        requestObject.TimeFrom      = self.dataSource["TimeFrom"].valueCandidate as! NSDate
        requestObject.TimeTo        = self.dataSource["TimeTo"].valueCandidate as! NSDate
        
        
        WebApiService.RequestCallback(requestObject){ objectReturn in
            
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
                    let alert = UIAlertController(title: "Error", message: temp1.Errors[0].ErrorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
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


}



//class CallEditor: TKDataFormPhoneEditor {
//    
//    let actionButton = UIButton()
//    
//    override init(property: TKEntityProperty, owner: TKDataForm) {
//        super.init(property: property, owner: owner)
//    }
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        actionButton.setTitle("Enter your number", forState: UIControlState.Normal)
//        actionButton.setTitleColor(UIColor.init(hex: "#357d89"), forState: UIControlState.Normal)
//        
//        self.addSubview(actionButton)
//        self.gridLayout.addArrangedView(actionButton)
//        let btnDef = self.gridLayout.definitionForView(actionButton)
//        btnDef.row = 0
//        btnDef.column = 3
//        self.gridLayout.setWidth(actionButton.sizeThatFits(CGSizeZero).width, forColumn: 3)
//    }
//    
//    override init(property: TKEntityProperty) {
//        super.init(property: property)
//    }
//    
//    required convenience init(coder aDecoder: NSCoder) {
//        self.init(frame: CGRectZero)
//    }
//}

//class TimeEditor: TKDataFormTimePickerEditor {
//    
//    let actionButton = UIButton()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        actionButton.setTitle("From", forState: UIControlState.Normal)
//        actionButton.setTitleColor(UIColor(red: 0.780, green: 0.2, blue: 0.233, alpha: 1.0), forState: UIControlState.Normal)
//        self.addSubview(actionButton)
//        self.gridLayout.addArrangedView(actionButton)
//        let btnDef = self.gridLayout.definitionForView(actionButton)
//        btnDef.row = 0
//        btnDef.column = 3
//        self.gridLayout.setWidth(actionButton.sizeThatFits(CGSizeZero).width, forColumn: 3)
//    }
//    
//    override init(property: TKEntityProperty) {
//        super.init(property: property)
//    }
//    
//    required convenience init(coder aDecoder: NSCoder) {
//        self.init(frame: CGRectZero)
//    }
//}

