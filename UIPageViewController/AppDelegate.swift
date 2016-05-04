//
//  AppDelegate.swift
//  UIPageViewController
//
//  Created by PJ Vea on 3/27/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationDidTimout:"), name: TimerUIApplication.ApplicationDidTimoutNotification, object: nil)
//        
//        UIApplication.sharedApplication().idleTimerDisabled = false
        LocalDatabase.copyFile("inbox.sqlite")


        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
        LocalStore.setDeviceToken("")
        
        //Register for notification
        registerForPushNotifications(application)
        
        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject] {
            
            print("App open by click on push notification")
            
            let aps = notification["aps"] as! [String: AnyObject]
            // If your app wasn’t running and the user launches it by tapping the push notification, the push notification is passed to your app in the launchOptions
        }
        
        return true
    }

    func registerForPushNotifications(application: UIApplication) {
        
        var systemVersion = UIDevice.currentDevice().systemVersion;

        let notificationSettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
        application.registerForRemoteNotifications()
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // The callback for when the timeout was fired.
//    func applicationDidTimout(notification: NSNotification) {
//        
//        print("time out")
//    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //print("Device Token:", tokenString)
        
        LocalStore.setDeviceToken(tokenString)
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    
        print("Not allow to receive Notifycation")

        LocalStore.setDeviceToken("")
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print("Recived: \(userInfo)")
        //Parsing userinfo:
        var temp : NSDictionary = userInfo
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
        {
            var alertMsg = info["alert"] as! String
//            var alert: UIAlertView!
//            alert = UIAlertView(title: "", message: alertMsg, delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
            
            LocalStore.Alert((self.window?.rootViewController?.view)!, title: "Notice", message: alertMsg, indexPath: 3)

        }
        
        

    }
}

