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
    
    @IBOutlet weak var btClear: UIButton!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var threePartPayment   = ThreePartPayment()
    
    var ScheduleList = [PaymentTrackerRecordModel]()
    
    var isFormValidate : Bool = false
    
    var validate1 : Bool = true

    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var validate4 : Bool = true
    
    var validate5 : Bool = true
    
    var validate6 : Bool = true


    var dataForm1 = TKDataForm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btClear.hidden = true

        self.view.backgroundColor = UIColor.whiteColor()
        
        lbl_Question.text = "Can you pay the total amount in " + LocalStore.accessMaxNoPay().description + " payments within " + LocalStore.accessThreePartDateDurationDays().description + " days?"
        
        self.subView.hidden = true
        
        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self

        
        InitData()
        

        dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        
        dataForm1.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        self.subView.addSubview(dataForm1)
        
    }
    
    func InitData(){
        
        let totalAmount =  LocalStore.accessTotalOutstanding()
        
        if(LocalStore.accessMaxNoPay()==2){

            threePartPayment.FirstAmount = round(totalAmount/2).formatWithDecimal(2)

            threePartPayment.SecondAmount = (totalAmount - round(totalAmount/2)).formatWithDecimal(2)
            
        }
        else if(LocalStore.accessMaxNoPay()==3)
        {
            threePartPayment.FirstAmount = round(totalAmount/3).formatWithDecimal(2)

            threePartPayment.SecondAmount = round(totalAmount/3).formatWithDecimal(2)

            threePartPayment.ThirdAmount = (totalAmount - round(totalAmount/3) - round(totalAmount/3)).formatWithDecimal(2)
        }
        
        
        threePartPayment.FirstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        threePartPayment.SecondDate = threePartPayment.FirstDate
        threePartPayment.ThirdDate = threePartPayment.FirstDate
        
        dataSource.sourceObject = threePartPayment
        
        let FirstAmount = dataSource["FirstAmount"]
        FirstAmount.hintText = "First Amount"
        FirstAmount.editorClass = TKDataFormPhoneEditor.self
        
        
        dataSource["FirstDate"].image = UIImage(named: "calendar-1")
        dataSource["FirstDate"].hintText = "First Date"
        
        let SecondAmount = dataSource["SecondAmount"]
        SecondAmount.hintText = "Second Amount"
        SecondAmount.editorClass = TKDataFormPhoneEditor.self
        
        
        dataSource["SecondDate"].image = UIImage(named: "calendar-1")
        dataSource["SecondDate"].hintText = "Second Date"
        
        let ThirdAmount = dataSource["ThirdAmount"]
        ThirdAmount.hintText = "Third Amount"
        ThirdAmount.editorClass = TKDataFormPhoneEditor.self
        
        dataSource["ThirdDate"].image = UIImage(named: "calendar-1")
        dataSource["ThirdDate"].hintText = "Third Date"
        
        if(LocalStore.accessMaxNoPay()==2){
            ThirdAmount.hidden = true
            dataSource["ThirdDate"].hidden = true
        }
        
        dataForm1.dataSource = dataSource
        dataForm1.commitMode = TKDataFormCommitMode.Manual
        dataForm1.validationMode = TKDataFormValidationMode.Manual


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
                dataSource["FirstAmount"].errorMessage = "Please enter 1st payment instalment"
                self.validate1 = false
                return self.validate1

            }
            
            let floatValue = value.floatValue
            
            if (floatValue < 10)
            {
                dataSource["FirstAmount"].errorMessage = "1st payment should be greater than or equal to $10"
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
                    dataSource["FirstDate"].errorMessage = "1st payment date must be valid within next 7 days"
                    self.validate2 = false
                    return self.validate2

                }
                
                let firstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
                
                if(value.isLessThanDate(firstDate)){
                    dataSource["FirstDate"].errorMessage = "1st payment date must be valid within next 7 days"
                    self.validate2 = false
                    return self.validate2
                }
                
                self.validate2 = true
            }
        else
        if (propery.name == "SecondAmount") {
            
            let value = propery.valueCandidate.description
            if (value.length <= 0)
            {
                dataSource["SecondAmount"].errorMessage = "Please enter 2nd payment instalment"
                self.validate3 = false
                return self.validate3
                
            }
            
            let floatValue = value.floatValue
            
            if (floatValue < 10)
            {
                dataSource["SecondAmount"].errorMessage = "2nd payment should be greater than or equal to $10"
                self.validate3 = false
                return self.validate3
            }
            
            self.validate3 = true
            
        }
        
        else
            if (propery.name == "SecondDate") {
                
                let value = propery.valueCandidate as! NSDate
                
                let firstDate = self.dataSource["FirstDate"].valueCandidate as! NSDate
                
                let Maxdate = firstDate.addDays(14)

                if(value.isLessThanDate(firstDate)){
                    dataSource["SecondDate"].errorMessage = "2nd payment date must be later than 1st instalment date"
                    self.validate4 = false
                    return self.validate4
                }
                
                if(value.equalToDate(firstDate)){
                    dataSource["SecondDate"].errorMessage = "2nd payment date must be later than 1st instalment date"
                    self.validate4 = false
                    return self.validate4
                }
                
                if(value.isGreaterThanDate(Maxdate)){
                    dataSource["SecondDate"].errorMessage = "Maximum time between two payments is 14 days"
                    self.validate4 = false
                    return self.validate4
                    
                }
                
                self.validate4 = true
        }
        
        if(LocalStore.accessMaxNoPay()==3)
        {
            if (propery.name == "ThirdAmount") {
                
                let value = propery.valueCandidate.description
                if (value.length <= 0)
                {
                    dataSource["ThirdAmount"].errorMessage = "Please enter 3rd payment instalment"
                    self.validate5 = false
                    return self.validate5
                    
                }
                
                let floatValue = value.floatValue
                
                if (floatValue < 10)
                {
                    dataSource["ThirdAmount"].errorMessage = "3rd payment should be greater than or equal to $10.00"
                    self.validate5 = false
                    return self.validate5
                }
                
                self.validate5 = true
                
            }
                
            else
                if (propery.name == "ThirdDate") {
                    
                    let value = propery.valueCandidate as! NSDate
                    
                    let secondDate = self.dataSource["SecondDate"].valueCandidate as! NSDate
                    
                    let Maxdate = secondDate.addDays(14)
                    
                    if(value.isLessThanDate(secondDate)){
                        dataSource["ThirdDate"].errorMessage = "3rd payment date must be after the 2nd instalment date"
                        self.validate6 = false
                        return self.validate6
                    }
                    
                    if(value.equalToDate(secondDate)){
                        dataSource["ThirdDate"].errorMessage = "3rd payment date must be after the 2nd instalment date"
                        self.validate6 = false
                        return self.validate6
                    }
                    
                    if(value.isGreaterThanDate(Maxdate)){
                        dataSource["ThirdDate"].errorMessage = "Maximum between 2 payments is 14 days"
                        self.validate6 = false
                        return self.validate6
                        
                    }
                    
                    self.validate6 = true
            }
        }
        
        
        return true
    }
    
    @IBAction func switch_Changed(sender: AnyObject) {
        
        if mySwitch.on {
            self.subView.hidden = false
            mySwitch.setOn(true, animated:true)
            self.btNext.setTitle("Next", forState: UIControlState.Normal)
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.btClear.hidden = false
            
            })

            
        } else {
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.btClear.hidden = true
            })
            
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
        
        
        if(mySwitch.on) {
            
            self.dataForm1.commit()
            
            var totalAmount : Double =  0
            
            if(LocalStore.accessMaxNoPay()==2)
            {
                totalAmount = self.dataSource["FirstAmount"].valueCandidate.description.doubleValue + self.dataSource["SecondAmount"].valueCandidate.description.doubleValue
                
            }
            else
            {
                let amount1String = self.dataSource["FirstAmount"].valueCandidate.description
                
                let amount1Number = amount1String.doubleValue
                
                let amount2String = self.dataSource["SecondAmount"].valueCandidate.description
                
                let amount2Number = amount2String.doubleValue
                
                let amount3String = self.dataSource["ThirdAmount"].valueCandidate.description
                
                let amount3Number = amount3String.doubleValue
                
                totalAmount = amount1Number + amount2Number + amount3Number
 
            }
            
            
            
            if(totalAmount.formatWithDecimal(2) != LocalStore.accessTotalOutstanding().formatWithDecimal(2)){
                
                //Format number
                
                LocalStore.Alert(self.view, title: "Error", message: "Instalment Amount total is not valid", indexPath: 0)
                
                return
                
            }
            
            self.isFormValidate = self.validate1 && self.validate2 && self.validate3 && self.validate4 && self.validate5 && self.validate6
            
            if(self.isFormValidate){
                
                SetPayment.SetPayment(2)
                
                LocalStore.setFrequency(0)

                self.performSegueWithIdentifier("GoToInstalmentSumary", sender: nil)
            }
            
        }
        else
        {
            SetPayment.SetPayment(3)
            
            self.performSegueWithIdentifier("GoTo4Payment", sender: nil)

        }

    }
    
    @IBAction func BtClear_Clicked(sender: AnyObject) {
        
        self.InitData()

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToInstalmentSumary" {

            
            self.ScheduleList.removeAll()
            
            let firstPayment = PaymentTrackerRecordModel()
            
            firstPayment.DueDate = (self.dataSource["FirstDate"].valueCandidate as! NSDate).formattedWith("dd/MM/yyyy")
            firstPayment.Amount = self.dataSource["FirstAmount"].valueCandidate.description
            
            self.ScheduleList.append(firstPayment)

            
            let secondPayment = PaymentTrackerRecordModel()
            
            secondPayment.DueDate = (self.dataSource["SecondDate"].valueCandidate as! NSDate).formattedWith("dd/MM/yyyy")
            secondPayment.Amount = self.dataSource["SecondAmount"].valueCandidate.description

            self.ScheduleList.append(secondPayment)
            
            if(LocalStore.accessMaxNoPay()==3)
            {
                let thirdPayment = PaymentTrackerRecordModel()
                
                thirdPayment.DueDate = (self.dataSource["ThirdDate"].valueCandidate as! NSDate).formattedWith("dd/MM/yyyy")
                thirdPayment.Amount = self.dataSource["ThirdAmount"].valueCandidate.description
                
                self.ScheduleList.append(thirdPayment)
            }
            
            let instalmentSumaryViewController = segue.destinationViewController as! InstalmentSumaryViewController
            
            instalmentSumaryViewController.ScheduleList = self.ScheduleList
        }
    }
    



}
