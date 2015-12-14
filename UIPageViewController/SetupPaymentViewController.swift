//
//  SetupPaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 14/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class SetupPaymentViewController: TKDataFormViewController {

    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    let threePartPayment   = ThreePartPayment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.subView.hidden = true
        
        let totalAmount =  LocalStore.accessTotalOutstanding()!.floatValue
        
        threePartPayment.FirstAmount = totalAmount/3
        threePartPayment.SecondAmount = totalAmount/3
        threePartPayment.ThirdAmount = totalAmount/3
        
        threePartPayment.FirstDate = NSDate()
        
        let components: NSDateComponents = NSDateComponents()
        components.setValue(14, forComponent: NSCalendarUnit.Day);
        threePartPayment.SecondDate  = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: threePartPayment.FirstDate, options: NSCalendarOptions(rawValue: 0))!
        
        threePartPayment.ThirdDate  = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: threePartPayment.SecondDate, options: NSCalendarOptions(rawValue: 0))!
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        dataSource.sourceObject = threePartPayment
        
        let FirstAmount = dataSource["FirstAmount"]
        FirstAmount.hintText = "First Amount"
        FirstAmount.errorMessage = "Please fill in 1st Payment"
        dataSource["FirstAmount"].editorClass = TKDataFormDecimalEditor.self

        
        
        dataSource["FirstDate"].image = UIImage(named: "calendar-1")
        dataSource["FirstDate"].hintText = "First Date"
        
        let SecondAmount = dataSource["SecondAmount"]
        SecondAmount.hintText = "Second Amount"
        SecondAmount.errorMessage = "Please fill in 2nd Payment"
        dataSource["SecondAmount"].editorClass = TKDataFormDecimalEditor.self

        
        
        dataSource["SecondDate"].image = UIImage(named: "calendar-1")
        dataSource["SecondDate"].hintText = "Second Date"
        
        let ThirdAmount = dataSource["ThirdAmount"]
        ThirdAmount.hintText = "Third Amount"
        ThirdAmount.errorMessage = "Please fill in 3rd Payment"
        dataSource["ThirdAmount"].editorClass = TKDataFormDecimalEditor.self

        
        
        dataSource["ThirdDate"].image = UIImage(named: "calendar-1")
        dataSource["ThirdDate"].hintText = "Third Date"
        

        
        self.dataForm.dataSource = dataSource
        self.dataForm.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        self.dataForm.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        dataForm.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        
        self.subView.addSubview(dataForm)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
//        if propery.name == "Name" {
//            return (propery.valueCandidate as! NSString).length > 0
//        }
        return true
    }
    @IBAction func switch_Changed(sender: AnyObject) {
        
        if mySwitch.on {
            self.subView.hidden = false
            mySwitch.setOn(true, animated:true)
            self.btNext.setTitle("Process", forState: UIControlState.Normal)
        } else {
            self.subView.hidden = true
            mySwitch.setOn(false, animated:true)
            self.btNext.setTitle("4 or More Payments", forState: UIControlState.Normal)
        }
        
    }
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
        editor.style.textLabelOffset = UIOffsetMake(10, 0)
        editor.style.separatorLeadingSpace = 40
        editor.style.accessoryArrowStroke = TKStroke(color: UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0))
        
        if ["FirstDate", "SecondDate", "ThirdDate"].contains(property.name) {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
            let titleDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: titleDef.column.integerValue)
            editor.style.editorOffset = UIOffsetMake(10, 0)
        }

    }
    
    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
//        groupView.titleView.titleLabel.textColor = UIColor.lightGrayColor()
//        groupView.titleView.titleLabel.font = UIFont.systemFontOfSize(13)
//        groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0)
//        if groupIndex == 1 {
//            groupView.editorsContainer.backgroundColor = UIColor.clearColor()
//        }
    }
    


}
