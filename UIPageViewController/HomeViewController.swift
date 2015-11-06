//
//  ViewController.swift
//  test
//
//  Created by andy synotive on 15/09/2015.
//  Copyright © 2015 andy synotive. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , TKSideDrawerDelegate {
    
    
    var sideDrawerView: TKSideDrawerView? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        sideDrawerView = TKSideDrawerView(frame: self.view.bounds)
        self.view.addSubview(sideDrawerView!)

        
        // tao nav bar
        let navBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        
        let navItem = UINavigationItem(title: "Getting Started")

        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        let showSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
        
        navItem.leftBarButtonItem = showSideDrawerButton
        navBar.items = [navItem]
        
        sideDrawerView!.mainView.addSubview(navBar)
        

        // create menu
        
        let sectionPrimary = sideDrawerView!.sideDrawer.addSectionWithTitle("Main")
        sectionPrimary.addItemWithTitle("Make a payment", image: UIImage(named: "dollar")!)
        sectionPrimary.addItemWithTitle("Payment Tracker", image: UIImage(named: "payment")!)
        sectionPrimary.addItemWithTitle("Instalment Info",image: UIImage(named: "info")!)
        sectionPrimary.addItemWithTitle("Defer Payment",image: UIImage(named: "defer")!)
        sectionPrimary.addItemWithTitle("Schedule Callback",image: UIImage(named: "callback")!)
        sectionPrimary.addItemWithTitle("Inbox",image: UIImage(named: "Inbox")!)
        
        let sectionLabels = sideDrawerView!.sideDrawer.addSectionWithTitle("Setting")
        sectionLabels.addItemWithTitle("Update credit card detail")
        sectionLabels.addItemWithTitle("Update bank account")
        sectionLabels.addItemWithTitle("Update personal information")
        sectionLabels.addItemWithTitle("Feedback")
        
        sideDrawerView!.sideDrawer.delegate = self
 
    }
    
    
    func showSideDrawer() {
        self.sideDrawerView!.sideDrawer.transition = TKSideDrawerTransitionType.Push
        self.sideDrawerView!.sideDrawer.fill = TKSolidFill(color: UIColor(rgba: "#00757D"))
        self.sideDrawerView!.sideDrawer.show()
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        NSLog("Selected item in section: %ld at index: %ld ", indexPath.section, indexPath.row)
        if(indexPath.section == 0 )
        {
            if(indexPath.row == 0 ){
                
                self.performSegueWithIdentifier("GoToMakePayment", sender: nil)
//                let paymentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MakePaymentViewController") as! MakePaymentViewController
//                //
//                self.navigationController!.pushViewController(paymentViewController, animated: true)
            }
        }
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForItemAtIndexPath indexPath: NSIndexPath!) {
        let section = sideDrawer.sections[indexPath.section] as! TKSideDrawerSection
        section.style.textColor = UIColor.whiteColor()
        
        let item = section.items[indexPath.item] as! TKSideDrawerItem
        item.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        item.style.separatorColor = TKSolidFill(color: UIColor(white: 1, alpha: 0.5))
        item.style.textColor = UIColor.whiteColor()
        item.style.imagePosition = TKSideDrawerItemImagePosition.Left
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

