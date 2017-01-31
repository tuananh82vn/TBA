//
//  DirectDebitTCViewController.swift
//  UIPageViewController
//
//  Created by Anh Pham on 31/1/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import UIKit

class DirectDebitTCViewController: UIViewController {

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

}
