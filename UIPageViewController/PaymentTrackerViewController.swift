//
//  PaymentTrackerViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PaymentTrackerViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var paymentTrackerRecord = [PaymentTrackerRecordModel]()
    
    var HistoryList = [PaymentTrackerRecordModel]()

    var ScheduleList = [PaymentTrackerRecordModel]()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initData()
                

        // Do any additional setup after loading the view.
    }
    
    func initData(){
        
        WebApiService.GetDebtorInfo(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    self.HistoryList = temp1.HistoryList
                    
                    self.ScheduleList = temp1.ScheduleList

                    self.paymentTrackerRecord = self.ScheduleList
                    
                    if(self.paymentTrackerRecord.count == 0){
                        self.tableView.hidden = true
                    }
                    else
                    {
                        self.tableView.hidden = false
                    }
                    
                    self.tableView.reloadData()

                }
            }
            else
            {
                
                // create the alert
                let alert = SCLAlertView()
                alert.hideWhenBackgroundViewIsTapped = true
                alert.showError("Error", subTitle:"Server not found.")
                
            }
        }

        
    }

    @IBAction func SegmentButton_Clicked(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
            
                self.paymentTrackerRecord = self.ScheduleList
                
                if(self.paymentTrackerRecord.count == 0){
                    self.tableView.hidden = true
                }
                else
                {
                    self.tableView.hidden = false
                }
                
                self.tableView.reloadData()
            case 1:
            
                self.paymentTrackerRecord = self.HistoryList
                
                if(self.paymentTrackerRecord.count == 0){
                    self.tableView.hidden = true
                }
                else
                {
                    self.tableView.hidden = false
                }
                
                self.tableView.reloadData()
            
            default:
            
                break;
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.paymentTrackerRecord.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! PaymentTrackerViewCell
        
        cell1.lb_Amount.text = "$ " + self.paymentTrackerRecord[indexPath.row].Amount
        
        cell1.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate
        
        
        return cell1
        
    }
    
    @IBAction func btPayment_Clicked(sender: AnyObject) {
        
        SetPayment.SetPayment(4)
        
        self.performSegueWithIdentifier("GoToMakeCreditPayment", sender: nil)

        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
