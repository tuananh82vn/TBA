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

    @IBOutlet weak var lb_NoPayment: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initData()
        
        WebApiService.sendActivityTracking("Open Payment Tracker")


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
                        self.tableView.isHidden = true
                        self.lb_NoPayment.text = "No current arrangement for this account. Would you like to make a payment now ?"
                    }
                    else
                    {
                        self.tableView.isHidden = false
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

    @IBAction func SegmentButton_Clicked(_ sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
            
                self.paymentTrackerRecord = self.InstalmentScheduleList
                
                if(self.InstalmentScheduleList.count == 0){
                    self.tableView.isHidden = true
                    self.lb_NoPayment.text = "No current arrangement for this account. Would you like to make a payment now ?"
                }
                else
                {
                    self.tableView.isHidden = false
                }
                
                self.tableView.reloadData()
            case 1:
            
                self.paymentTrackerRecord = self.HistoryInstalmentScheduleList
                
                if(self.HistoryInstalmentScheduleList.count == 0){
                    self.tableView.isHidden = true
                    self.lb_NoPayment.text = "You have not made any payments on this arrangement. Would you like to make a payment now ?"

                }
                else
                {
                    self.tableView.isHidden = false
                }
                
                self.tableView.reloadData()
            
            default:
            
                break;
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.paymentTrackerRecord.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! PaymentTrackerViewCell
        
        
//        //Format number
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.currencySymbol = "$"

        cell1.lb_Amount.text = Double(self.paymentTrackerRecord[indexPath.row].Amount.doubleValue).formatAsCurrency()


        
        var tempDate = self.paymentTrackerRecord[indexPath.row].DueDate
        cell1.lb_DueDate.text = tempDate
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        let DueDate = dateFormatter.date(from: tempDate)

        
        let CurrentDate = Date()
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
            
                let PayAmount = self.paymentTrackerRecord[indexPath.row].PayAmount.doubleValue
                let DeferAmount = self.paymentTrackerRecord[indexPath.row].Defer.doubleValue
                let PayDate = self.paymentTrackerRecord[indexPath.row].PayDate
            
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
    
    @IBAction func btPayment_Clicked(_ sender: AnyObject) {
        
        SetPayment.SetPayment(4)
        
        self.performSegue(withIdentifier: "GoToMakeCreditPayment", sender: nil)

        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
