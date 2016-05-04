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

    }
    
    func initData(){
        
        WebApiService.GetDebtorPaymentHistory(LocalStore.accessRefNumber()!) { objectReturn in
            
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
            
                self.paymentTrackerRecord = self.ScheduleList
                
                if(self.ScheduleList.count == 0){
                    self.tableView.hidden = true
                }
                else
                {
                    self.tableView.hidden = false
                }
                
                self.tableView.reloadData()
            case 1:
            
                self.paymentTrackerRecord = self.HistoryList
                
                if(self.HistoryList.count == 0){
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
        
        if( segmentedControl.selectedSegmentIndex == 0 )
        {
                if(DueDate!.isLessThanDate(CurrentDate)){
                
                    cell1.img_Status.image = UIImage(named: "circle_red")
                }
                else
                {
                    cell1.img_Status.image = nil
                }
        }
        else
        {
                if(Amount <= 0){
                    
                    cell1.img_Status.image = UIImage(named: "circle_red")
                }
                else if(Amount < LocalStore.accessNextPaymentInstallment())
                {
                    cell1.img_Status.image = UIImage(named: "circle_red")
                }
                else
                {
                    cell1.img_Status.image = UIImage(named: "circle_blue")
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
