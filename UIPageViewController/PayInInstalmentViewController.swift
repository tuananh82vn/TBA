//
//  SetupInstalmentPayment.swift
//  UIPageViewController
//
//  Created by andy synotive on 15/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit


class PayInInstalmentViewController : UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()

    var payInInstalment   = PayInInstalment()

    var isFormValidate : Bool = false
    
    var validate1 : Bool = true
    
    var validate2 : Bool = true
    
    var validate3 : Bool = true
    
    var dataForm1 = TKDataForm()
    
    var ScheduleList = [PaymentTrackerRecordModel]()

    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var lb_LastInstalmentDate: UILabel!
    @IBOutlet weak var lb_NumberOfInstalment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        //Format number
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"


        dataForm1 = TKDataForm(frame: self.subView.bounds)
        dataForm1.delegate = self
        InitData()

        dataForm1.frame = CGRect(x: 0, y: 0, width: self.subView.bounds.size.width, height: self.subView.bounds.size.height - 66)
        dataForm1.tintColor = UIColor(red: 0.780, green: 0.2, blue: 0.223, alpha: 1.0)
        dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
        
        self.subView.addSubview(dataForm1)

    }
    
    func InitData(){
        
        dataSource.sourceObject = payInInstalment
        
        if(LocalStore.accessIsAllowMonthlyInstallment()!){
            dataSource["Frequency"].valuesProvider = [ "Weekly", "Fortnightly","Monthly"]
        }
        else
        {
            dataSource["Frequency"].valuesProvider = [ "Weekly", "Fortnightly"]
        }
        
        let InstalmentAmount = dataSource["InstalmentAmount"]
        InstalmentAmount?.hintText = "Instalment Amount"
        InstalmentAmount?.editorClass = TKDataFormDecimalEditor.self
        
        self.dataSource.addGroup(withName: "", propertyNames: ["Frequency", "InstalmentAmount","FirstInstalmentDate"])
        

        dataForm1.dataSource = dataSource
        dataForm1.commitMode = TKDataFormCommitMode.manual
        dataForm1.validationMode = TKDataFormValidationMode.immediate
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func btNext_Clicked(_ sender: AnyObject) {
        
        self.dataForm1.commit()
        self.dataForm1.commit()

        self.isFormValidate = self.validate1 && self.validate2 && self.validate3
        
        if(self.isFormValidate){

            SetPayment.SetPayment(3)
            
            self.performSegue(withIdentifier: "GoToInstalmentSumary", sender: nil)
        }

    }
    
    
    func dataForm(_ dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    func dataForm(_ dataForm: TKDataForm, heightForEditorInGroup gorupIndex: UInt, at editorIndex: UInt) -> CGFloat {
        return 65
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        
        property.hintText = property.displayName
        
        self.performTopAlignmentSettingsForEditor(editor, property: property)
        
//        if (property.name == "FirstInstalmentDate" || property.name == "LastInstalmentDate") {
//                let textEditor = editor as! TKDataFormDatePickerEditor
//                textEditor.datePicker.setValue(UIColor.black, forKey: "textColor")
//                textEditor.datePicker.datePickerMode = .date
//        }
    }

    func dataForm(_ dataForm: TKDataForm, didSelect editor: TKDataFormEditor, for property: TKEntityProperty) {
        let borderColor = UIColor(red:0.000, green:0.478, blue:1.000, alpha:1.00)
        var layer = editor.editor.layer
        
        if editor.isKind(of: TKDataFormDatePickerEditor.self) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
        }
        
        let currentBorderColor = UIColor(cgColor: layer.borderColor!)
        layer.borderColor = borderColor.cgColor
        let animate = CABasicAnimation(keyPath: "borderColor")
        animate.fromValue = currentBorderColor
        animate.toValue = borderColor
        animate.duration = 0.4
        layer.add(animate, forKey: "borderColor")
    }
    
    func dataForm(_ dataForm: TKDataForm, didDeselect editor: TKDataFormEditor, for property: TKEntityProperty) {

        if editor.isKind(of: TKDataFormDatePickerEditor.self) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            dateEditor.editorValueLabel.layer.borderColor = UIColor(red:0.784, green:0.780, blue:0.800, alpha:1.00).cgColor
        }
        
        editor.editor.layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).cgColor
    }
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if (propery.name == "Frequency") {
            let amount = (self.dataSource["InstalmentAmount"].valueCandidate as AnyObject).description.doubleValue.roundTo(places: 2)
            if(amount > 0 ){
                Calculation()
            }
        }
        
        if (propery.name == "InstalmentAmount") {
            
            let value = (propery.valueCandidate as AnyObject).description
            if ((value?.length)! <= 0)
            {
                dataSource["InstalmentAmount"].errorMessage = "Please enter payment instalment"
                self.validate1 = false
                return self.validate1
                
            }
            
            let floatValue = value?.doubleValue
            
            
            let frequency = self.dataSource["Frequency"].valueCandidate as! Int
            
            if(frequency == 0 ){
                if (floatValue! < LocalStore.accessWeeklyAmount())
                {
                    dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                    self.validate1 = false
                    return self.validate1
                }
                else
                {
                    //Calculation
                    Calculation()
                }
            }
            else
                if(frequency == 1 ){
                    if (floatValue! < LocalStore.accessFortnightAmount())
                    {
                        dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                        self.validate1 = false
                        return self.validate1
                    }
                    else
                    {
                        Calculation()
                    }
            }
            else
                    if(frequency == 2 ){
                        if (floatValue! < LocalStore.accessMonthlyAmount())
                        {
                            dataSource["InstalmentAmount"].errorMessage = "Payment does not meet your negotiated limit"
                            self.validate1 = false
                            return self.validate1
                        }
                        else{
                            Calculation()
                        }
            }

            self.validate1 = true
            
        }
        else
            if (propery.name == "FirstInstalmentDate") {
                
                let value = propery.valueCandidate as! Date
                
                let Maxdate = Date() + 30.days
                
                let firstDate = Calendar.current.startOfDay(for: Date())

                
                if(value.isGreaterThanDate(Maxdate) || value.isLessThanDate(firstDate)){
                    dataSource["FirstInstalmentDate"].errorMessage = "1st payment date must be valid within next 30 days"
                    self.validate2 = false
                    return self.validate2
                    
                }
                else
                {
                    Calculation()
                }
                
                self.validate2 = true
        }
        
        return true
    }
    
    func Calculation(){
        
        self.ScheduleList.removeAll()
        
        var installmentDate = self.dataSource["FirstInstalmentDate"].valueCandidate as! Date
        
        var paidAmount : Double = 0
        let amount = (self.dataSource["InstalmentAmount"].valueCandidate as AnyObject).description.doubleValue.roundTo(places: 2)
        
        let totalAmount = LocalStore.accessTotalOutstanding()
        var installmentAmount =  amount < totalAmount ? amount : totalAmount
        
        let Frequency = self.dataSource["Frequency"].valueCandidate as! Int
        
        LocalStore.setFrequency(Frequency+1)
        
        
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
                installmentAmount = (totalAmount - paidAmount).roundTo(places: 2)
            }
            switch(Frequency){
                case 0:
                        installmentDate = installmentDate + 7.days
                        break
                
                case 1:
                        installmentDate = installmentDate + 14.days
                        break
                    
                case 2:
                        installmentDate = installmentDate + 1.month
                        break
                    
                default: break
            }
        }
        
        if(self.ScheduleList.count > 0){
            
            
            let lastInstallment = self.ScheduleList[self.ScheduleList.count - 1].Amount.doubleValue
            
            if( lastInstallment < 10){
                self.ScheduleList.remove(at: self.ScheduleList.count-1)
                self.ScheduleList[self.ScheduleList.count-1].Amount = (self.ScheduleList[self.ScheduleList.count-1].Amount.doubleValue + lastInstallment).description
            }
            

            self.lb_LastInstalmentDate.text = ScheduleList.last?.DueDate
            self.lb_NumberOfInstalment.text = self.ScheduleList.count.description

            
        }
        
        
    }
    
    
    func performTopAlignmentSettingsForEditor(_ editor: TKDataFormEditor, property: TKEntityProperty) {
        
        editor.style.separatorColor = nil
        editor.textLabel.font = UIFont.systemFont(ofSize: 15)
        editor.style.insets = UIEdgeInsetsMake(1, editor.style.insets.left, 5, editor.style.insets.right)
        
        
        let gridLayout = editor.gridLayout
        let editorDef = gridLayout.definition(for: editor.editor)
        editorDef?.row = 1
        editorDef?.column = 1
        
        if property.name == "FirstInstalmentDate" || property.name == "LastInstalmentDate" {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            let labelDef = gridLayout.definition(for: dateEditor.editorValueLabel)
            labelDef?.row = 1
            labelDef?.column = 1
        }
        
        let feedbackLabelDef = gridLayout.definition(for: editor.feedbackLabel)
        feedbackLabelDef?.row = 2
        feedbackLabelDef?.column = 1
        feedbackLabelDef?.columnSpan = 1
        
        self.setEditorStyle(editor)
        
    }
    
    func setEditorStyle(_ editor: TKDataFormEditor) {
        if editor.selected {
            return;
        }
        
        var layer = editor.editor.layer
        
        if editor.isKind(of: TKDataFormDatePickerEditor.self) {
            let dateEditor = editor as! TKDataFormDatePickerEditor
            layer = dateEditor.editorValueLabel.layer
            dateEditor.editorValueLabel.layer.borderWidth = 1.0
            dateEditor.editorValueLabel.layer.borderColor = UIColor.gray.cgColor
            dateEditor.showAccessoryImage = false
            dateEditor.editorValueLabel.textInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        }
        else
        if editor.isKind(of: TKDataFormTextFieldEditor.self) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }

        
        layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToInstalmentSumary" {
            
            
            Calculation();
            
            let instalmentSumaryViewController = segue.destination as! InstalmentSumaryViewController
            
            instalmentSumaryViewController.ScheduleList = self.ScheduleList
        }
    }

}

// Overloading + and - so that we can add and subtract DateComponents
// ------------------------------------------------------------------

func +(_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
    return combineComponents(lhs, rhs)
}

func -(_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
    return combineComponents(lhs, rhs, multiplier: -1)
}

func combineComponents(_ lhs: DateComponents,
                       _ rhs: DateComponents,
                       multiplier: Int = 1)
    -> DateComponents {
        var result = DateComponents()
        result.second     = (lhs.second     ?? 0) + (rhs.second     ?? 0) * multiplier
        result.minute     = (lhs.minute     ?? 0) + (rhs.minute     ?? 0) * multiplier
        result.hour       = (lhs.hour       ?? 0) + (rhs.hour       ?? 0) * multiplier
        result.day        = (lhs.day        ?? 0) + (rhs.day        ?? 0) * multiplier
        result.weekOfYear = (lhs.weekOfYear ?? 0) + (rhs.weekOfYear ?? 0) * multiplier
        result.month      = (lhs.month      ?? 0) + (rhs.month      ?? 0) * multiplier
        result.year       = (lhs.year       ?? 0) + (rhs.year       ?? 0) * multiplier
        return result
}



// We'll need to overload unary - so we can negate components
prefix func -(components: DateComponents) -> DateComponents {
    var result = DateComponents()
    if components.second     != nil { result.second     = -components.second! }
    if components.minute     != nil { result.minute     = -components.minute! }
    if components.hour       != nil { result.hour       = -components.hour! }
    if components.day        != nil { result.day        = -components.day! }
    if components.weekOfYear != nil { result.weekOfYear = -components.weekOfYear! }
    if components.month      != nil { result.month      = -components.month! }
    if components.year       != nil { result.year       = -components.year! }
    return result
}


// Date + DateComponents
func +(_ lhs: Date, _ rhs: DateComponents) -> Date
{
    return Calendar.current.date(byAdding: rhs, to: lhs)!
}

// DateComponents + Dates
func +(_ lhs: DateComponents, _ rhs: Date) -> Date
{
    return rhs + lhs
}

