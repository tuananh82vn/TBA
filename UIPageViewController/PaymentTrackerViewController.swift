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

    var paymentTrackerRecord = [PaymentTrackerRecordModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
                
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func initData(){
        let record1 = PaymentTrackerRecordModel()
        record1.Amount = "$ 100.00"
        record1.DueDate = "12/20/2015"
        record1.Remaining = "$ 1000.00"
        record1.PaymentStatusId = 2
        paymentTrackerRecord.append(record1)
        
        let record2 = PaymentTrackerRecordModel()
        record2.Amount = "$ 100.00"
        record2.DueDate = "12/20/2015"
        record2.Remaining = "$ 1000.00"
        record2.PaymentStatusId = 0
        paymentTrackerRecord.append(record2)
        
        let record3 = PaymentTrackerRecordModel()
        record3.Amount = "$ 100.00"
        record3.DueDate = "12/20/2015"
        record3.Remaining = "$ 1000.00"
        record3.PaymentStatusId = 1
        paymentTrackerRecord.append(record3)
        
        let record4 = PaymentTrackerRecordModel()
        record4.Amount = "$ 100.00"
        record4.DueDate = "12/20/2015"
        record4.Remaining = "$ 1000.00"
        record4.PaymentStatusId = 0
        paymentTrackerRecord.append(record4)
        
        
        let record5 = PaymentTrackerRecordModel()
        record5.Amount = "$ 100.00"
        record5.DueDate = "12/20/2015"
        record5.Remaining = "$ 1000.00"
        record5.PaymentStatusId = 1
        paymentTrackerRecord.append(record5)
        
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
        
        cell1.lb_Amount.text = self.paymentTrackerRecord[indexPath.row].Amount
        
        cell1.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate
        
        cell1.lb_Remaining.text = self.paymentTrackerRecord[indexPath.row].Remaining
        
        if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 0 ){
            cell1.img_Status.image = UIImage(named: "circle_blue")
        }
        else
            if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 1 ){
                cell1.img_Status.image = UIImage(named: "circle_red")
        }
        else
                if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 2 ){
                    cell1.img_Status.image = UIImage(named: "circle_green")
        }
        
        return cell1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
