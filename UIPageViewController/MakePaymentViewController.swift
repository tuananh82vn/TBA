//
//  SelectDebtorController.swift
//  UIPageViewController
//
//  Created by andy synotive on 5/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0



class MakePaymentViewController: UIViewController {
    
    
    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()

    @IBOutlet weak var bt_InstalmentPlan: UIButton!
    var IsExistingPlan : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(LocalStore.accessIsExistingArrangement()! || LocalStore.accessIsExistingArrangementCC()! || LocalStore.accessIsExistingArrangementDD()!)
        {
            IsExistingPlan = true
            bt_InstalmentPlan.setTitle("View My Instalment Plan", for: UIControlState.normal)
        }
        else
        {
            IsExistingPlan = false
            bt_InstalmentPlan.setTitle("Create an Instalment Plan", for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PayAnAmount_Clicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToMakePayment", sender: nil)
        
    }
    
    
    @IBAction func InstalmentPlan_Clicked(_ sender: Any) {
        if(IsExistingPlan){
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "InstalmentInfoViewController") as! InstalmentInfoViewController
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        else
        {
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "CreateInstalmentPlanViewController") as! CreateInstalmentPlanViewController
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GoToMakeCreditPayment" {
//
//            let makeCreditPaymentViewController = segue.destination as! MakeCreditPaymentViewController
//            
//            makeCreditPaymentViewController.DebtorPaymentInstallmentList = self.DebtorPaymentInstallmentList
//            
//        }
//        else
//            if segue.identifier == "GoToMakeDebitPayment" {
//                let makeCreditPaymentViewController = segue.destination as! MakeDebitPaymentViewController
//                
//                makeCreditPaymentViewController.DebtorPaymentInstallmentList = self.DebtorPaymentInstallmentList
//        }

    }

    
}
