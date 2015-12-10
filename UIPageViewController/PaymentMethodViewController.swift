//
//  SelectDebtorController.swift
//  UIPageViewController
//
//  Created by andy synotive on 5/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0



class PaymentMethodViewController: UIViewController {
    
    
    var paymentList = ["Credit Card","Direct Debit"]
    var selectMethod : Int = -1
    
    @IBOutlet weak var bt_Method: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bt_MethodSelected(sender: AnyObject) {
        
        ActionSheetStringPicker.showPickerWithTitle("Select", rows: paymentList as [AnyObject] , initialSelection: 0, doneBlock: {
            picker, value, index in
            
            self.selectMethod = value
            self.bt_Method.setTitle((index as! String), forState: .Normal)
            
            return
            
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
        
    }
    
    @IBAction func bt_ContinueClicked(sender: AnyObject) {
        
        if(self.selectMethod != -1)
        {
            if(self.selectMethod == 0){
                self.performSegueWithIdentifier("GoToMakeCreditPayment", sender: nil)
            }
            else
            {
                self.performSegueWithIdentifier("GoToMakeDebitPayment", sender: nil)
            }
        }
        else
        {
            
            // create the alert
            let alert = UIAlertController(title: "Warning", message: "Please select payment method", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
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
