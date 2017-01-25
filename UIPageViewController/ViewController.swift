////
////  ViewController.swift
////  UIPageViewController
////
////  Created by PJ Vea on 3/27/15.
////  Copyright (c) 2015 Vea Software. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController, UIPageViewControllerDataSource {
//
//    var pageViewController: UIPageViewController!
//
//    var viewControler = ["View1Controller","View2Controller"]
//    
//    var IsPinSetup : Bool = false
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        
//        
//
//        
//        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
//
//            
//            if(LocalStore.accessIsPinSetup()){
//                self.IsPinSetup = true
//                self.viewControler = ["PinLoginViewController"]
//            }
//            else
//            {
//                //disable moving view - because if view animate - keyboard will disapear
//                self.pageViewController.dataSource = self
//            }
//        
//
//
//        let vc1 = self.viewControllerAtIndex(0)
//        
//        let viewControllers = NSArray(object: vc1)
//        
//
//        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
//
//        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.size.height - 60)
//        
//        self.addChildViewController(self.pageViewController)
//        
//        self.view.addSubview(self.pageViewController.view)
//        
//        self.pageViewController.didMove(toParentViewController: self)
//        
//        
//    }
//    
//    func viewControllerAtIndex(_ index : Int ) -> UIViewController {
//
//            let contentViewController =  self.storyboard?.instantiateViewController(withIdentifier: self.viewControler[index]) as! BaseViewController
//        
//            contentViewController.rootViewController = self
//        
//            return contentViewController
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//
//    
//    // MARK: - Page View Controller Data Source
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
//    {
//        
//        let vcRestorationID = viewController.restorationIdentifier
//        
//        var index =  viewControler.index(of: (vcRestorationID!))
//        
//        if (index == 0) {
//            return nil;
//        }
//        
//        index! -= 1
//
//        return self.viewControllerAtIndex(index!)
//        
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        let vcRestorationID = viewController.restorationIdentifier
//
//        var index =  viewControler.index(of: (vcRestorationID!))
//        
//        if (index == self.viewControler.count-1) {
//            return nil;
//        }
//        index! += 1
//        
//        return self.viewControllerAtIndex(index!)
//  
//    }
//    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int
//    {
//        if(self.IsPinSetup)
//        {
//            return 0
//        }
//        return 2
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int
//    {
//        return 0
//    }
//    
//    func goToNextContentViewController() {
//        
//        let currentViewController = self.pageViewController.viewControllers![0] 
//        let vcRestorationID = currentViewController.restorationIdentifier
//        var index =  viewControler.index(of: (vcRestorationID!))
//        
//        index! += 1
//        
//        let nextViewController = self.viewControllerAtIndex(index!)
//        
//        let viewControllers = NSArray(object: nextViewController)
//        
//        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
//    }
//    
////    func goToPreviousContentViewController(){
////        
////        let currentViewController = self.pageViewController.viewControllers![0] 
////        let vcRestorationID = currentViewController.restorationIdentifier
////        var index =  viewControler.indexOf((vcRestorationID!))
////        
////        index!--
////        
////        let nextViewController = self.viewControllerAtIndex(index!)
////        
////        let viewControllers = NSArray(object: nextViewController)
////        
////        self.pageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: .Reverse, animated: true, completion: nil)
////    }
//    
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
