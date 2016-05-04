//
//  View1Controller.swift
//  UIPageViewController
//
//  Created by synotivemac on 7/09/2015.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

//protocol View1ControllerDelegate : class {
//    
//    func View1Controller_SlideNextClicked(controller:View1Controller)
//    
//}

class View1Controller: BaseViewController {

//    weak var delegate: View1ControllerDelegate?

    @IBOutlet weak var lb_welcomeMessage: UILabel!
    var pageIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        WebApiService.getWelcomeMessage() { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.Errors.count > 0){
                    self.lb_welcomeMessage.text = temp1.Errors[0].ErrorMessage
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SlideNextClicked(sender: AnyObject) {
        self.rootViewController.goToNextContentViewController()
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
