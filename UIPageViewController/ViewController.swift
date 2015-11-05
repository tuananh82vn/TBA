//
//  ViewController.swift
//  UIPageViewController
//
//  Created by PJ Vea on 3/27/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
   // var currentPage = 0
   // var curentIndex = 0
    var viewControler = ["View1Controller","View2Controller"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self

        let vc1 = self.viewControllerAtIndex(0)
        
        let viewControllers = NSArray(object: vc1)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }
    
    func viewControllerAtIndex(index : Int ) -> UIViewController {
        
            let contentViewController =  self.storyboard?.instantiateViewControllerWithIdentifier(self.viewControler[index]) as! BaseViewController
        
            contentViewController.rootViewController = self
        
            return contentViewController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        let vcRestorationID = viewController.restorationIdentifier
        
        var index =  viewControler.indexOf((vcRestorationID!))
        
        if (index == 0) {
            return nil;
        }
        
        index!--

        return self.viewControllerAtIndex(index!)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vcRestorationID = viewController.restorationIdentifier

        var index =  viewControler.indexOf((vcRestorationID!))
        
        if (index == self.viewControler.count-1) {
            return nil;
        }
        index!++
        
        return self.viewControllerAtIndex(index!)
  
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 2
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    func goToNextContentViewController() {
        
        let currentViewController = self.pageViewController.viewControllers![0] 
        let vcRestorationID = currentViewController.restorationIdentifier
        var index =  viewControler.indexOf((vcRestorationID!))
        
        index!++
        
        let nextViewController = self.viewControllerAtIndex(index!)
        
        let viewControllers = NSArray(object: nextViewController)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    func goToPreviousContentViewController(){
        
        let currentViewController = self.pageViewController.viewControllers![0] 
        let vcRestorationID = currentViewController.restorationIdentifier
        var index =  viewControler.indexOf((vcRestorationID!))
        
        index!--
        
        let nextViewController = self.viewControllerAtIndex(index!)
        
        let viewControllers = NSArray(object: nextViewController)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: .Reverse, animated: true, completion: nil)
    }
    

}





















