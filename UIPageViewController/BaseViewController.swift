//
//  BaseViewController.swift
//  UIPageViewController
//
//  Created by synotivemac on 9/10/2015.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit
import Spring

class BaseViewController: UIViewController {

    
    var rootViewController = ViewController()
    
  //  var domain = "http://wsandypham:3333"
    var domain = "http://180.94.114.42:3333"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocalStore.setWeb_URL_API(domain)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
