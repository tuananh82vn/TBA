//
//  CreditCardTCViewController.swift
//  UIPageViewController
//
//  Created by Anh Pham on 31/1/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import UIKit

class CreditCardTCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btBack_Clicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
