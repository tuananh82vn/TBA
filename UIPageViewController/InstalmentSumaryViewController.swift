//
//  InstalmentSumaryViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 11/02/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit

class InstalmentSumaryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var tableView: UITableView!
    var ScheduleList = [PaymentTrackerRecordModel]()

    var DebtorPaymentInstallmentList = Array<DebtorPaymentInstallment>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ScheduleList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! PaymentTrackerViewCell
        
        cell1.lb_Amount.text = "$ " + self.ScheduleList[indexPath.row].Amount
        
        cell1.lb_DueDate.text = self.ScheduleList[indexPath.row].DueDate
        
        
        return cell1
        
    }
    
    @IBAction func btNext_Clicked(sender: AnyObject) {
        
        
        LocalStore.setFirstAmountOfInstalment(ScheduleList[0].Amount.doubleValue)
        
        self.performSegueWithIdentifier("GoToPaymentOption", sender: nil)

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToPaymentOption" {
            
            for(var i = 0 ; i < self.ScheduleList.count ; i++){
                
                let temp1 = DebtorPaymentInstallment()
                
                temp1.PaymentDate = self.ScheduleList[i].DueDate
                
                let formatter = NSDateFormatter()
                
                formatter.dateFormat =  NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-AU"))
                
                let date1 = formatter.dateFromString(temp1.PaymentDate)
                
                let dateFormatter = NSDateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                temp1.PaymentDate = dateFormatter.stringFromDate(date1!)
                
                temp1.Amount = self.ScheduleList[i].Amount.doubleValue

                self.DebtorPaymentInstallmentList.append(temp1)
            }
            
            
            let paymentMethodViewController = segue.destinationViewController as! PaymentMethodViewController
            
            paymentMethodViewController.DebtorPaymentInstallmentList = self.DebtorPaymentInstallmentList
        }
    }



}
