//
//  SetupInstalmentPayment.swift
//  UIPageViewController
//
//  Created by andy synotive on 15/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit


class PayInInstalmentViewController : UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()

    var payInInstalment   = PayInInstalment()

    var isFormValidate : Bool = false
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var dataForm1 = TKDataForm()
    
    var ScheduleList = [PaymentTrackerRecordModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //Format number
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        
        if(LocalStore.accessIsAllowMonthlyInstallment()!){
        
                lbQuestion.text = "Would you like to check if you qualify for a weekly/fortnightly or monthly payment schedule to meet your obligation in paying the amount of " + formatter.stringFromNumber(LocalStore.accessTotalOutstanding())! + " ?"
        }
        else
        {
                lbQuestion.text = "Would you like to check if you qualify for a weekly/fortnightly payment schedule to meet your obligation in paying the amount of " + formatter.stringFromNumber(LocalStore.accessTotalOutstanding())! + " ?"
        }
        
        self.subView.hidden = true
        
        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self
        
        InitData()

        dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        dataForm1.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        self.subView.addSubview(dataForm1)

        // Do any additional setup after loading the view.
    }
    
    func InitData(){
        
        dataSource.sourceObject = payInInstalment
        
        if(LocalStore.accessIsAllowMonthlyInstallment()!){
            dataSource["Frequency"].valuesProvider = [ "Weekly", "Fornightly","Monthly"]
        }
        else
        {
            dataSource["Frequency"].valuesProvider = [ "Weekly", "Fornightly"]
        }
        
        let InstalmentAmount = dataSource["InstalmentAmount"]
        InstalmentAmount.hintText = "Instalment Amount"
        InstalmentAmount.editorClass = TKDataFormDecimalEditor.self
        
        self.dataSource.addGroupWithName("", propertyNames: ["Frequency", "InstalmentAmount","FirstInstalmentDate"])

        
        dataForm1.dataSource = dataSource
        dataForm1.commitMode = TKDataFormCommitMode.Manual
        dataForm1.validationMode = TKDataFormValidationMode.Manual

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btNo_Clicked(sender: AnyObject) {
        self.subView.hidden = true

    }
    
    @IBAction func btYes_Clicked(sender: AnyObject) {
        self.subView.hidden = false

    }
    
    @IBAction func btNext_Clicked(sender: AnyObject) {
        
        self.dataForm1.commit()

        self.isFormValidate = self.validate1 && self.validate2 && self.validate3
        
        if(self.isFormValidate){

            SetPayment.SetPayment(3)
            
            self.performSegueWithIdentifier("GoToInstalmentSumary", sender: nil)
        }

    }
    @IBAction func btClear_Clicked(sender: AnyObject) {
    }
    
    func dataForm(dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    func dataForm(dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, atIndex editorIndex: UInt) -> CGFloat {
        return 65
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
    
    func dataForm(dataForm: TKDataForm, didDeselectEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            dateEditor.editorValueLabel.layer.borderColor = UIColor(red:0.784, green:0.780, blue:0.800, alpha:1.00).CGColor
        }
        
        editor.editor.layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).CGColor
    }
    
    func dataForm(dataForm: TKDataForm, validateProperty propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        
        if (propery.name == "InstalmentAmount") {
            
            let value = propery.valueCandidate.description
            if (value.length <= 0)
            {
                dataSource["InstalmentAmount"].errorMessage = "Please enter payment instalment"
                self.validate1 = false
                return self.validate1
                
            }
            
            let floatValue = value.doubleValue
            
            
            let frequency = self.dataSource["Frequency"].valueCandidate as! Int
            
            if(frequency == 0 ){
                if (floatValue < LocalStore.accessWeeklyAmount())
                {
                    dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                    self.validate1 = false
                    return self.validate1
                }
            }
            else
                if(frequency == 1 ){
                    if (floatValue < LocalStore.accessFortnightAmount())
                    {
                        dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                        self.validate1 = false
                        return self.validate1
                    }
            }
            else
                    if(frequency == 2 ){

                        if (floatValue < LocalStore.accessMonthlyAmount())
                        {
                            dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                            self.validate1 = false
                            return self.validate1
                        }
            }
            
           
            
            self.validate1 = true
            
        }
        else
            if (propery.name == "FirstInstalmentDate") {
                
                let value = propery.valueCandidate as! NSDate
                
                let Maxdate = NSDate().addDays(30)
                
                let firstDate = NSCalendar.currentCalendar().startOfDayForDate(NSDate())

                
                if(value.isGreaterThanDate(Maxdate) || value.isLessThanDate(firstDate)){
                    dataSource["FirstInstalmentDate"].errorMessage = "1st payment date must be valid within next 30 days"
                    self.validate2 = false
                    return self.validate2
                    
                }
                
                self.validate2 = true
        }
        
        return true
    }
    
    func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        

        property.hintText = property.displayName
        
        self.performTopAlignmentSettingsForEditor(editor, property: property)
        
    }
    
    
    func performTopAlignmentSettingsForEditor(editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
        editor.textLabel.font = UIFont.systemFontOfSize(15)
        editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right)
        
        
        let gridLayout = editor.gridLayout
        let editorDef = gridLayout.definitionForView(editor.editor)
        editorDef?.row = 1
        editorDef?.column = 1
        
        if property.name == "FirstInstalmentDate" {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            let labelDef = gridLayout.definitionForView(dateEditor.editorValueLabel)
            labelDef.row = 1
            labelDef.column = 1
        }
        
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
        
        if editor.isKindOfClass(TKDataFormDatePickerEditor) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
            dateEditor.editorValueLabel.layer.borderWidth = 1.0
            dateEditor.editorValueLabel.layer.borderColor = UIColor.grayColor().CGColor
            dateEditor.showAccessoryImage = false
            dateEditor.editorValueLabel.textInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        }
        else
        if editor.isKindOfClass(TKDataFormTextFieldEditor) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }

        
        layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToInstalmentSumary" {
            
            
            self.ScheduleList.removeAll()
            
            var installmentDate = self.dataSource["FirstInstalmentDate"].valueCandidate as! NSDate
            
            var paidAmount : Double = 0
            var amount = self.dataSource["InstalmentAmount"].valueCandidate.description.doubleValue.roundToPlaces(2)
            var totalAmount = LocalStore.accessTotalOutstanding()
            var installmentAmount =  amount < totalAmount ? amount : totalAmount
            
            let Frequency = self.dataSource["Frequency"].valueCandidate as! Int
            
            while ( totalAmount > paidAmount && installmentAmount > 0)
            {
                let firstPayment = PaymentTrackerRecordModel()
                
                firstPayment.DueDate = installmentDate.formattedWith("dd/MM/yyyy")
                
                firstPayment.Amount = installmentAmount.description
                
                self.ScheduleList.append(firstPayment)
                
                paidAmount = paidAmount + installmentAmount
                
                if( paidAmount + amount <= totalAmount)
                {
                    installmentAmount = amount
                }
                else
                {
                    installmentAmount = (totalAmount - paidAmount).roundToPlaces(2)
                }
                
                switch(Frequency){
                    case 0:
                    installmentDate = installmentDate.addDays(7)
                    break
                    
                    case 1:
                    installmentDate = installmentDate.addDays(14)
                    break
                
                    case 2:
                    installmentDate = installmentDate.addMonths(1)
                    break
                    
                    default: break
                }
            }
            
            if(self.ScheduleList.count > 0){
                
                
                var lastInstallment = self.ScheduleList[self.ScheduleList.count - 1].Amount.doubleValue
                
                if( lastInstallment < 10){
                    self.ScheduleList.removeAtIndex(self.ScheduleList.count-1)
                    self.ScheduleList[self.ScheduleList.count-1].Amount = (self.ScheduleList[self.ScheduleList.count-1].Amount.doubleValue + lastInstallment).description
                }
            }

            
            let instalmentSumaryViewController = segue.destinationViewController as! InstalmentSumaryViewController
            
            instalmentSumaryViewController.ScheduleList = self.ScheduleList
        }
    }


    
}
