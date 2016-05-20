
import UIKit

class DeferPaymentViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var btDefer: UIButton!

    @IBOutlet weak var tableView: UITableView!
    
    var paymentTrackerRecord = [PaymentTrackerRecordModel]()
    
    var HistoryList = [PaymentTrackerRecordModel]()
        
    var selectedIndex = -1
    
    var TotalDefer = 0
    
    var TotalUsed = 0
    
    var TotalNewUsed = 0
    
    var OrginTotalNewUsed = 0

    @IBOutlet weak var view_NoDefer: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        initData()
        

    }
    
    func initData(){
        
        WebApiService.GetDebtorInfo(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    
                    //Do filtering
                    for historyItem in temp1.HistoryInstalmentScheduleList {

                        let DeferAmount = historyItem.Defer.doubleValue
                        let PayAmount = historyItem.PayAmount.doubleValue
                        let PayDate = historyItem.PayDate

                        if(DeferAmount > 0)
                        {
                            
                        }
                        else if (PayAmount == 0 && PayDate == "")
                        {
                            self.HistoryList.append(historyItem)
                        }
                        
                    }
                    
                    
                    self.TotalDefer = temp1.TotalDefer
                    
                    self.TotalUsed = temp1.TotalUsedDefer

                    self.paymentTrackerRecord = self.HistoryList
                    
                    if(self.paymentTrackerRecord.count > 0)
                    {
                        self.btDefer.setTitle("You used " + self.TotalUsed.description + " of " + self.TotalDefer.description, forState: UIControlState.Normal)

                        self.view_NoDefer.hidden = true
                        self.tableView.hidden = false
                        self.tableView.reloadData()
                    }
                    else
                    {
                        self.btDefer.setTitle("Schedule Callback", forState: UIControlState.Normal)

                        self.view_NoDefer.hidden = false
                        self.tableView.hidden = true
                    }
                    
                }
            }
            else
            {
                
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                
            }
        }
        
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.paymentTrackerRecord.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! DeferPaymentViewCell
        
        
        cell.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate

        
        //Format number
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle

        cell.lb_Amount.text  = formatter.stringFromNumber(self.paymentTrackerRecord[indexPath.row].Amount.doubleValue)

        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedIndex = indexPath.row
        
        if(self.TotalUsed ==  self.TotalDefer)
        {
            LocalStore.Alert(self.view, title: "Error", message: "You have deferred the maximum number of payments. Please schedule a callback from RecoveriesCorp", indexPath: 0)

            self.btDefer.setTitle("Schedule Callback", forState: UIControlState.Normal)
        }
        else
        {
            self.btDefer.setTitle("Defer this payment ?", forState: UIControlState.Normal)
        }
    }

    @IBAction func btDefer_Clicked(sender: UIButton)
    {
        
        if(self.paymentTrackerRecord.count > 0){
            
            if(selectedIndex == -1)
            {
                LocalStore.Alert(self.view, title: "Error", message: "Please select the payment you want to defer.", indexPath: 0)
            }
            else
            {
                if(self.TotalUsed ==  self.TotalDefer)
                {
                    self.performSegueWithIdentifier("GoToScheduleCallback", sender: nil)
                }
                else
                {
                
                    var payment = self.paymentTrackerRecord[self.selectedIndex]
                    
                    self.view.showLoading()
                        
                    let requestObject = DeferPayment()
                    
                    requestObject.InstalDate        = payment.DueDate
                    requestObject.Amount            = payment.Amount
                    
                    
                    WebApiService.SendDeferPayment(requestObject){ objectReturn in
                        
                        self.view.hideLoading();
                        
                        if let temp1 = objectReturn
                        {
                            
                            if(temp1.IsSuccess)
                            {
                                self.performSegueWithIdentifier("GoToNotice", sender: nil)
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
            }

        }
        else
        {
            self.performSegueWithIdentifier("GoToScheduleCallback", sender: nil)
            
        }
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destinationViewController as! FinishViewController
            controller.message = "Your defer payment has been setup successfully"
            
        }
    }
    
}
