
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
                        self.btDefer.setTitle("You used " + self.TotalUsed.description + " of " + self.TotalDefer.description, for: UIControlState())

                        self.view_NoDefer.isHidden = true
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                    else
                    {
                        self.btDefer.setTitle("Schedule Callback", for: UIControlState())

                        self.view_NoDefer.isHidden = false
                        self.tableView.isHidden = true
                    }
                    
                }
            }
            else
            {
                
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                
            }
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.paymentTrackerRecord.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! DeferPaymentViewCell
        
        
        cell.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate



        cell.lb_Amount.text  = self.paymentTrackerRecord[indexPath.row].Amount.doubleValue.formatAsCurrency()

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        if(self.TotalUsed ==  self.TotalDefer)
        {
            LocalStore.Alert(self.view, title: "Error", message: "You have deferred the maximum number of payments. Please schedule a callback from RecoveriesCorp", indexPath: 0)

            self.btDefer.setTitle("Schedule Callback", for: UIControlState())
        }
        else
        {
            self.btDefer.setTitle("Defer this payment ?", for: UIControlState())
        }
    }

    @IBAction func btDefer_Clicked(_ sender: UIButton)
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
                    self.performSegue(withIdentifier: "GoToScheduleCallback", sender: nil)
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
                                self.performSegue(withIdentifier: "GoToNotice", sender: nil)
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
                    
                    WebApiService.sendActivityTracking("Defer")

                }
            }

        }
        else
        {
            self.performSegue(withIdentifier: "GoToScheduleCallback", sender: nil)
            
        }
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "You have successfully deferred this payment."
            
        }
    }
    
}
