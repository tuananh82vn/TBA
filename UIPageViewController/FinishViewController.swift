//
//  FInishCallbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 14/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    
    var message = ""
    
    @IBOutlet weak var lbMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMessage.text = message
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false) //or animated: false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btFinish_Clicked(sender: AnyObject) {
        
        self.navigationController?.viewControllers.removeAll()
        
        
        self.performSegueWithIdentifier("GoToHomepage", sender: nil)

    }


}


