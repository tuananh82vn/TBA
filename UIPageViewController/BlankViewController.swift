//
//  BlankViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 6/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class BlankViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideDrawerGettingStarted = storyboard.instantiateViewControllerWithIdentifier("HomeViewController")
        
        let navController = UINavigationController.init(rootViewController: sideDrawerGettingStarted)
        
        let sideDrawerController = TKSideDrawerController(content: navController)
        
        self.view.window?.frame =  UIScreen.mainScreen().bounds
        
        self.view.window?.rootViewController = sideDrawerController
        
        self.view.window?.makeKeyAndVisible()

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func continueClicked(sender: AnyObject) {

    }


}
