//
//  SelectDebtorController.swift
//  UIPageViewController
//
//  Created by andy synotive on 5/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0



class SelectDebtorController: UIViewController {

    
    var debtorList = [CoDebtor]()
    
    var debtorNameList = [String]()
    
    var selectDebtor : Int = 0

    @IBOutlet weak var bt_Debtor: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for var index = 0; index < debtorList.count; ++index {
            debtorNameList.append(debtorList[index].FullName + " - " + debtorList[index].MarkMobile)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bt_DebtorSelected(sender: AnyObject) {
        
        ActionSheetStringPicker.showPickerWithTitle("Select", rows: debtorNameList as [AnyObject] , initialSelection: self.selectDebtor, doneBlock: {
            picker, value, index in
            
            self.selectDebtor = value
            
            self.bt_Debtor.setTitle((index as! String), forState: .Normal)
            
            return
            
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        
    }

    @IBAction func bt_ContinueClicked(sender: AnyObject) {
        
        if(self.debtorList[self.selectDebtor].Mobile == "No Number")
        {
            self.performSegueWithIdentifier("GoToVerifyDetail", sender: nil)

        }
        else
        {
            self.performSegueWithIdentifier("GoToVerify", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToVerify" {
            
            let controller = segue.destinationViewController as! VerifyCoDebtorViewController
            controller.selectedDebtor = self.debtorList[self.selectDebtor]
        }
        else
            if segue.identifier == "GoToVerifyDetail" {
                
                let controller = segue.destinationViewController as! VerifyDetailCoDebtorViewController
                controller.selectedDebtor = self.debtorList[self.selectDebtor]
        }
    }
    

}
