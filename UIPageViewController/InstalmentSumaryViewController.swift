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
        
        WebApiService.sendActivityTracking("Open Instalment Summary")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ScheduleList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! PaymentTrackerViewCell
        


        cell1.lb_Amount.text = self.ScheduleList[indexPath.row].Amount.doubleValue.formatAsCurrency()
        
        cell1.lb_DueDate.text = self.ScheduleList[indexPath.row].DueDate
        
        
        return cell1
        
    }
    
    @IBAction func btNext_Clicked(_ sender: AnyObject) {
        
        
        LocalStore.setFirstAmountOfInstalment(ScheduleList[0].Amount.doubleValue)
        
        self.performSegue(withIdentifier: "GoToPaymentOption", sender: nil)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPaymentOption" {
            
            for i in 0  ..< self.ScheduleList.count
            {
                
                let temp1 = DebtorPaymentInstallment()
                
                temp1.PaymentDate = self.ScheduleList[i].DueDate
                
                let formatter = DateFormatter()
                
                formatter.dateFormat =  DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale: Locale(identifier: "en-AU"))
                
                let date1 = formatter.date(from: temp1.PaymentDate)
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                temp1.PaymentDate = dateFormatter.string(from: date1!)
                
                temp1.Amount = self.ScheduleList[i].Amount.doubleValue

                self.DebtorPaymentInstallmentList.append(temp1)
            }
            
            
            let paymentMethodViewController = segue.destination as! PaymentMethodViewController
            
            paymentMethodViewController.DebtorPaymentInstallmentList = self.DebtorPaymentInstallmentList
        }
    }



}
