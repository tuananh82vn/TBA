//
//  SetupPaymentViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 14/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class SetupPaymentViewController: UIViewController , TKDataFormDelegate {

    @IBOutlet weak var lbl_Question: UILabel!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    let threePartPayment   = ThreePartPayment()
    
    var ScheduleList = [PaymentTrackerRecordModel]()
    
    var isFormValidate : Bool = false
    
    var validate1 : Bool = true

    var validate2 : Bool = true


    var dataForm1 = TKDataForm()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        lbl_Question.text = "Can you pay the total amount in " + LocalStore.accessMaxNoPay().description + " payments within " + LocalStore.accessThreePartDateDurationDays().description + " days?"
        
        self.subView.hidden = true
        

        let totalAmount =  LocalStore.accessTotalOutstanding()!.floatValue
        
        
        if(LocalStore.accessMaxNoPay()==2){
            
            threePartPayment.FirstAmount = roundf(totalAmount/2)
            threePartPayment.SecondAmount = totalAmount - roundf(totalAmount/2)
        }
        else if(LocalStore.accessMaxNoPay()==3)
        {
            threePartPayment.FirstAmount = roundf(totalAmount/3)
            threePartPayment.SecondAmount = roundf(totalAmount/3)
            threePartPayment.ThirdAmount = totalAmount - roundf(totalAmount/3)*2
        }

        
        threePartPayment.FirstDate = NSDate()
    
        
        dataSource.sourceObject = threePartPayment

        let FirstAmount = dataSource["FirstAmount"]
        FirstAmount.hintText = "First Amount"
        FirstAmount.editorClass = TKDataFormNumberEditor.self


        dataSource["FirstDate"].image = UIImage(named: "calendar-1")
        dataSource["FirstDate"].hintText = "First Date"
        
        let SecondAmount = dataSource["SecondAmount"]
        SecondAmount.hintText = "Second Amount"
        SecondAmount.editorClass = TKDataFormNumberEditor.self

        
        dataSource["SecondDate"].image = UIImage(named: "calendar-1")
        dataSource["SecondDate"].hintText = "Second Date"
        
        let ThirdAmount = dataSource["ThirdAmount"]
        ThirdAmount.hintText = "Third Amount"
        ThirdAmount.editorClass = TKDataFormNumberEditor.self
        
        dataSource["ThirdDate"].image = UIImage(named: "calendar-1")
        dataSource["ThirdDate"].hintText = "Third Date"
        
        if(LocalStore.accessMaxNoPay()==2){
            ThirdAmount.hidden = true
            dataSource["ThirdDate"].hidden = true
        }
        
        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self
        dataForm1.dataSource = dataSource
        
        dataForm1.commitMode = TKDataFormCommitMode.Manual
        dataForm1.validationMode = TKDataFormValidationMode.Manual
        
        dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        dataForm1.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        
        self.subView.addSubview(dataForm1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        
        if (propery.name == "FirstAmount") {
            
            let value = propery.valueCandidate.description
            if (value.length <= 0)
            {
                dataSource["FirstAmount"].errorMessage = "Please enter 1st payment instalment."
                self.validate1 = false
                return self.validate1

            }
            
            let floatValue = value.floatValue
            
            if (floatValue < 10)
            {
                dataSource["FirstAmount"].errorMessage = "1st payment should be greater than or equal to $10."
                self.validate1 = false
                return self.validate1
            }
            
            self.validate1 = true

        }
        else
            if (propery.name == "FirstDate") {

                let value = propery.valueCandidate as! NSDate
                
                let Maxdate = NSDate().addDays(7)
                
                if(value.isGreaterThanDate(Maxdate)){
                    dataSource["FirstDate"].errorMessage = "1st payment date must be valid within next seven days."
                    self.validate2 = false
                    return self.validate2

                }
                
                self.validate2 = true


        }
        
        self.isFormValidate = self.validate1 && self.validate2
        
        return true
    }
    
    @IBAction func switch_Changed(sender: AnyObject) {
        
        if mySwitch.on {
            self.subView.hidden = false
            mySwitch.setOn(true, animated:true)
            self.btNext.setTitle("Next", forState: UIControlState.Normal)
        } else {
            self.subView.hidden = true
            mySwitch.setOn(false, animated:true)
            self.btNext.setTitle("4 or More Payments", forState: UIControlState.Normal)
        }
        
    }
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        
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
    
    @IBAction func btNext_Clicked(sender: AnyObject) {
        
        self.dataForm1.commit()
        
        if(LocalStore.accessMaxNoPay()==2){
        
        }
        
        if(self.isFormValidate){
            
            self.performSegueWithIdentifier("GoToPaymentSumary", sender: nil)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToPaymentSumary" {

            
            self.ScheduleList.removeAll()
            
            let firstPayment = PaymentTrackerRecordModel()
            
            firstPayment.DueDate = (self.dataSource["FirstDate"].valueCandidate as! NSDate).formattedWith("dd/MM/yyyy")
            firstPayment.Amount = self.dataSource["FirstAmount"].valueCandidate.description
            
            self.ScheduleList.append(firstPayment)

            
            let secondPayment = PaymentTrackerRecordModel()
            
            secondPayment.DueDate = (self.dataSource["SecondDate"].valueCandidate as! NSDate).formattedWith("dd/MM/yyyy")
            secondPayment.Amount = self.dataSource["SecondAmount"].valueCandidate.description

            self.ScheduleList.append(secondPayment)
            
            let instalmentSumaryViewController = segue.destinationViewController as! InstalmentSumaryViewController
            
            instalmentSumaryViewController.ScheduleList = self.ScheduleList
        }
    }
    
//    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
//    }
    


}
