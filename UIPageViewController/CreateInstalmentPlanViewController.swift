//
//  CreateInstalmentPlanViewController.swift
//  UIPageViewController
//
//  Created by Anh Pham on 2/2/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import UIKit

class CreateInstalmentPlanViewController: UIViewController {

    @IBOutlet weak var lb_question: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lb_question.text = "Can you pay the total amount in " + LocalStore.accessMaxNoPay().description + " payments within " + LocalStore.accessThreePartDateDurationDays().description + " days?"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func blNo_Clicked(_ sender: Any) {
        
        WebApiService.sendActivityTracking("Setup instalment plan")
        
        SetPayment.SetPayment(3)
        
        self.performSegue(withIdentifier: "GoToSetupInstalment", sender: nil)
    }

    @IBAction func btYes_Clicked(_ sender: Any) {
        WebApiService.sendActivityTracking("Setup 2 part payment")
        
        SetPayment.SetPayment(2)
        
        self.performSegue(withIdentifier: "GoToSetup2Payments", sender: nil)
    }

}
