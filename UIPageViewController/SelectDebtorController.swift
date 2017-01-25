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
        
        for index in 0 ..< debtorList.count {
            debtorNameList.append(debtorList[index].FullName + " - " + debtorList[index].MarkMobile)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bt_DebtorSelected(_ sender: AnyObject) {
        
        ActionSheetStringPicker.show(withTitle: "Select", rows: debtorNameList as [AnyObject] , initialSelection: self.selectDebtor, doneBlock: {
            picker, value, index in
            
            self.selectDebtor = value
            
            self.bt_Debtor.setTitle((index as! String), for: .normal)
            
            return
            
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
    }

    @IBAction func bt_ContinueClicked(_ sender: AnyObject) {
        
        if(self.debtorList[self.selectDebtor].Mobile == "No Number")
        {
            self.performSegue(withIdentifier: "GoToVerifyDetail", sender: nil)

        }
        else
        {
            self.performSegue(withIdentifier: "GoToVerify", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToVerify" {
            
            let controller = segue.destination as! VerifyCoDebtorViewController
            controller.selectedDebtor = self.debtorList[self.selectDebtor]
        }
        else
            if segue.identifier == "GoToVerifyDetail" {
                
                let controller = segue.destination as! VerifyDetailCoDebtorViewController
                controller.selectedDebtor = self.debtorList[self.selectDebtor]
        }
    }
    

}
