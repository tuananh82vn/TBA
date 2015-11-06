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

    
    var debtorList = ["Andy Pham","Khanh Le"]
    var selectDebtor : Int = 0

    @IBOutlet weak var bt_Debtor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bt_DebtorSelected(sender: AnyObject) {
        
        ActionSheetStringPicker.showPickerWithTitle("Select", rows: debtorList as [AnyObject] , initialSelection: self.selectDebtor, doneBlock: {
            picker, value, index in
            
            self.bt_Debtor.setTitle((index as! String), forState: .Normal)
            
            return
            
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        
    }

    @IBAction func bt_ContinueClicked(sender: AnyObject) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
