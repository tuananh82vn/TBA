//
//  View2Controller.swift
//  UIPageViewController
//
//  Created by synotivemac on 7/09/2015.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class View2Controller: BaseViewController {

    
    var pageIndex : Int = 1
    
    @IBOutlet weak var bt_GetNetCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIPageControl.appearance().currentPage = 1
//        UIPageControl.appearance().updateCurrentPageDisplay()
//        println(UIPageControl.appearance().currentPage)
        
        // Do any additional setup after loading the view.
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.bt_GetNetCode.alpha = 1
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GetNetCodeClicked(sender: AnyObject) {
        doVerify()
    }
    
    @IBAction func ContinueClicked(sender: AnyObject) {
    }
    
    func doVerify(){
        
        self.view.showLoading();
        
        WebApiService.checkInternet({(internet:Bool) -> Void in
                
                if (internet)
                {
                    WebApiService.postVerify(LocalStore.accessWeb_URL_API()!){ objectReturn in
                        
                        
                        if let temp = objectReturn {
                            
                            if(temp.IsSuccess)
                            {
                                let customIcon = UIImage(named: "no-internet")
                                let alertview = JSSAlertView().show(self, title: "Warning", text: "Connections are available ", buttonText: "Try later", color: UIColorFromHex(0xe74c3c, alpha: 1), iconImage: customIcon)
                                alertview.setTextTheme(.Light)
                            }
                        }
                        else
                        {
                            self.view.hideLoading();
                            
                            let customIcon = UIImage(named: "no-internet")
                            let alertview = JSSAlertView().show(self, title: "Warning", text: "No connections are available ", buttonText: "Try later", color: UIColorFromHex(0xe74c3c, alpha: 1), iconImage: customIcon)
                            alertview.setTextTheme(.Light)
                            
                            
                        }
                        
                    }
                }
                else
                {
                    
                    self.view.hideLoading();
                    
                    let customIcon = UIImage(named: "no-internet")
                    let alertview = JSSAlertView().show(self, title: "Warning", text: "No connections are available ", buttonText: "Try later", color: UIColorFromHex(0xe74c3c, alpha: 1), iconImage: customIcon)
                    alertview.setTextTheme(.Light)
                }
        })
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
