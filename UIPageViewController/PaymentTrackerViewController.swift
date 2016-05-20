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
    
    var HistoryInstalmentScheduleList = [PaymentTrackerRecordModel]()

    var InstalmentScheduleList = [PaymentTrackerRecordModel]()
    
    var circle_red = UIImage(named: "circle_red")
    var circle_blue = UIImage(named: "circle_blue")
    var circle_yellow = UIImage(named: "circle_yellow")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initData()

    }
    
    func initData(){
        
        WebApiService.GetDebtorPaymentHistory(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    self.HistoryInstalmentScheduleList = temp1.HistoryInstalmentScheduleList
                    
                    self.InstalmentScheduleList = temp1.InstalmentScheduleList

                    self.paymentTrackerRecord = self.InstalmentScheduleList
                    
                    if(self.paymentTrackerRecord.count == 0){
                        self.tableView.hidden = true
                    }
                    else
                    {
                        self.tableView.hidden = false
                    }
                    
                    self.tableView.reloadData()

                }
                else
                {
                    if(temp1.Errors.count > 0){
                        LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                    }
                    else
                    {
                        LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                    }

                }
            }
            else
            {
                
                  LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                
            }
        }

        
    }

    @IBAction func SegmentButton_Clicked(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
            
                self.paymentTrackerRecord = self.InstalmentScheduleList
                
                if(self.InstalmentScheduleList.count == 0){
                    self.tableView.hidden = true
                }
                else
                {
                    self.tableView.hidden = false
                }
                
                self.tableView.reloadData()
            case 1:
            
                self.paymentTrackerRecord = self.HistoryInstalmentScheduleList
                
                if(self.HistoryInstalmentScheduleList.count == 0){
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
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.paymentTrackerRecord.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! PaymentTrackerViewCell
        
        
        //Format number
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        cell1.lb_Amount.text = formatter.stringFromNumber(self.paymentTrackerRecord[indexPath.row].Amount.doubleValue)


        
        var tempDate = self.paymentTrackerRecord[indexPath.row].DueDate
        cell1.lb_DueDate.text = tempDate
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        let DueDate = dateFormatter.dateFromString(tempDate)

        
        let CurrentDate = NSDate()
        let Amount = self.paymentTrackerRecord[indexPath.row].Amount.doubleValue
        
        
        //Schedule
        if( segmentedControl.selectedSegmentIndex == 0 )
        {
                if(DueDate!.isLessThanDate(CurrentDate)){
                
                    cell1.img_Status.image = circle_red
                }
                else
                {
                    cell1.img_Status.image = nil
                }
        }
        //History
        else
        {
            
                var PayAmount = self.paymentTrackerRecord[indexPath.row].PayAmount.doubleValue
                var DeferAmount = self.paymentTrackerRecord[indexPath.row].Defer.doubleValue
                var PayDate = self.paymentTrackerRecord[indexPath.row].PayDate
            
                if(Amount <= 0){
                    
                    cell1.img_Status.image = circle_red
                }
                else if(DeferAmount > 0)
                {
                    cell1.img_Status.image = self.circle_yellow
                }
                else if (PayAmount == 0 && PayDate == ""){
                    cell1.img_Status.image = circle_red
                }
                else if(Amount < LocalStore.accessNextPaymentInstallment())
                {
                    cell1.img_Status.image = circle_red
                }
                else
                {
                    cell1.img_Status.image = self.circle_blue
                }
        }

        
        return cell1
        
    }
    
    @IBAction func btPayment_Clicked(sender: AnyObject) {
        
        SetPayment.SetPayment(4)
        
        self.performSegueWithIdentifier("GoToMakeCreditPayment", sender: nil)

        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
