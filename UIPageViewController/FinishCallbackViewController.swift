//
//  FInishCallbackViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 14/12/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class FinishCallbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btFinish_Clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("GoToHomepage", sender: nil)

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
