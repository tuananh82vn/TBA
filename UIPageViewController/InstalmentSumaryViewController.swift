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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}
