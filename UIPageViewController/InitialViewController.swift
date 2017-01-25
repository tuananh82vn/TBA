//
//  InitialViewController.swift
//  UIPageViewController
//
//  Created by Anh Pham on 25/1/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(presentExampleController), with: nil, afterDelay: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentExampleController() {
        if(LocalStore.accessIsPinSetup()){
            //go to Login View
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            let vc = storyboard.instantiateViewController(withIdentifier: "PinLoginViewController") as! PinLoginViewController
//            
//            self.present(vc, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PinLoginViewController") as! PinLoginViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //show window
            appDelegate.window?.rootViewController = vc
            
        }
        else
        {
            //go to Setup View
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            let vc = storyboard.instantiateViewController(withIdentifier: "View2Controller") as! View2Controller
//            
//            self.present(vc, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "View2Controller") as! View2Controller
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //show window
            appDelegate.window?.rootViewController = vc
            

        }
        
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
