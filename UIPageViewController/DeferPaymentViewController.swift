
import UIKit

class DeferPaymentViewController: UIViewController  , TKListViewDelegate , TKListViewDataSource {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var btDefer: UIButton!

    var listView = TKListView()
    
    let dataSource = TKDataSource()

    var paymentTrackerRecord = [PaymentTrackerRecordModel]()
    
    var HistoryList = [PaymentTrackerRecordModel]()
        
    var selectedIndex = -1
    
    var TotalDefer = 0
    
    var TotalUsed = 0
    
    var TotalNewUsed = 0
    
    var OrginTotalNewUsed = 0

    @IBOutlet weak var lb_Message: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        listView = TKListView(frame: self.subView.bounds)
        
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        
        listView.dataSource = self
        listView.delegate = self
        listView.allowsCellSwipe = true
        listView.cellSwipeLimits = UIEdgeInsetsMake(0, 0, 0, 120)//how far the cell may swipe
        listView.cellSwipeTreshold = 60 // the treshold after which the cell will autoswipe to the end and will not jump back to the
        listView.registerClass(DeferPaymentViewCell.classForCoder(), forCellWithReuseIdentifier:"cell")

        self.subView.addSubview(listView)

        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemSize = CGSizeMake(100, 44)
        
        initData()

        // Do any additional setup after loading the view.
    }
    
    func initData(){
        
        WebApiService.GetDebtorInfo(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    
                    
                    //Do filtering
                    for historyItem in temp1.HistoryList {
                        
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy"
                        
                        let DueDate = dateFormatter.dateFromString(historyItem.DueDate)
                        
                        let CurrentDate = NSDate()
                        
                        if(DueDate!.isLessThanDate(CurrentDate)){
                        
                            if(historyItem.Defer.doubleValue > 0 )
                            {
                                self.HistoryList.append(historyItem)
                            }
                        }
                        else
                        {
                            self.HistoryList.append(historyItem)
                        }
                        
                    }
                    
                    self.TotalDefer = temp1.TotalDefer
                    
                    self.TotalUsed = temp1.TotalUsedDefer
                    
                    self.TotalNewUsed = temp1.TotalUsedDefer
                    
                    self.OrginTotalNewUsed = self.TotalNewUsed

                    self.paymentTrackerRecord = self.HistoryList
                    
                    if(self.paymentTrackerRecord.count > 0)
                    {
                        self.lb_Message.hidden = true
                        self.btDefer.hidden = true

                    }
                    else
                    {
                        self.btDefer.hidden = false

                        self.lb_Message.hidden = false
                    }
                    
                    self.listView.reloadData()
                }
            }
            else
            {
                
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    
                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    func btDefer_Clicked() {
        
        if(self.selectedIndex >= 0){
            
            if(self.paymentTrackerRecord[self.selectedIndex].Defer == "" || self.paymentTrackerRecord[self.selectedIndex].Defer == "0.00")
            {
                if(self.TotalDefer == self.TotalNewUsed){

                    LocalStore.Alert(self.view, title: "Error", message: "No more deferrals allowed", indexPath: 0)

                }
                else
                {
                    
                    self.TotalNewUsed = self.TotalNewUsed + 1
                
                    self.paymentTrackerRecord[self.selectedIndex].Defer = "Deferred"
            
                    self.btDefer.setTitle("Used " + self.TotalNewUsed.description + " of " + self.TotalDefer.description + ". Submit ?", forState: UIControlState.Normal)
                    
                    self.btDefer.hidden = false

                    self.listView.reloadData()
                }
                
            }
            else
            {
                LocalStore.Alert(self.view, title: "Error", message: "This payment is already deferred", indexPath: 0)

            }
        }
        
        listView.endSwipe(true)

    }
    
    func btUndo_Clicked() {
        
        if(self.selectedIndex >= 0){
            
            if(self.paymentTrackerRecord[self.selectedIndex].Defer == "Deferred")
            {
            
                self.TotalNewUsed = self.TotalNewUsed - 1
            
                self.paymentTrackerRecord[self.selectedIndex].Defer = ""
            
                self.btDefer.setTitle("Used " + self.TotalNewUsed.description + " of " + self.TotalDefer.description + ". Submit ?", forState: UIControlState.Normal)
            
                
                if(self.TotalNewUsed == self.OrginTotalNewUsed ){
                    self.btDefer.hidden = true
                }
                
                self.listView.reloadData()

            }
        }
        
        listView.endSwipe(true)
        
    }
    
    func animateButtonsInCell(cell: TKListViewCell, offset: CGPoint) {
        if(offset.x > 0){
            return
        }
        
        let btDefer = cell.swipeBackgroundView.subviews[0] as! UIButton
        
        let btUndo = cell.swipeBackgroundView.subviews[1] as! UIButton
        
        let size = cell.frame.size

        btDefer.frame = CGRectMake(size.width - 120, 0, 60, size.height)
        
        btUndo.frame = CGRectMake(size.width - 60, 0, 60, size.height)
        
        
    }
    

    func listView(listView: TKListView, didFinishSwipeCell cell: TKListViewCell, atIndexPath indexPath: NSIndexPath, withOffset offset: CGPoint) {
                
        self.selectedIndex = indexPath.row
        
        
    }

    func listView(listView: TKListView, didSwipeCell cell: TKListViewCell, atIndexPath indexPath: NSIndexPath, withOffset offset: CGPoint) {
        animateButtonsInCell(cell, offset: offset)
    }
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return self.paymentTrackerRecord.count
    }
    
    func listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DeferPaymentViewCell
        
        
        
        //Format number
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle

        cell.lb_Amount.text = formatter.stringFromNumber(self.paymentTrackerRecord[indexPath.row].Amount.doubleValue)
        cell.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate
        cell.lb_Defer.text = self.paymentTrackerRecord[indexPath.row].Defer
        
        if(self.paymentTrackerRecord[indexPath.row].Defer.doubleValue > 0  || self.paymentTrackerRecord[indexPath.row].Defer == "Deferred") {
            cell.img_Status.image = UIImage(named: "circle_red")
        }
        else
        {
            cell.img_Status.image = UIImage(named: "circle_blue")
        }
        
        
        
        
        if(cell.swipeBackgroundView.subviews.count == 0){
            let size = cell.frame.size
            let font = UIFont.systemFontOfSize(14)
            
            let btDefer = UIButton()
            btDefer.frame = CGRectMake(size.width - 120, 0, 60, size.height)
            btDefer.setTitle("Defer", forState: UIControlState.Normal)
            btDefer.backgroundColor = UIColor.orangeColor()
            btDefer.titleLabel?.font = font
            btDefer.addTarget(self, action: "btDefer_Clicked", forControlEvents: UIControlEvents.TouchUpInside)
            cell.swipeBackgroundView.addSubview(btDefer)
            
            let btUndo = UIButton()
            btUndo.frame = CGRectMake(size.width - 60, 0, 60, size.height)
            btUndo.setTitle("Undo", forState: UIControlState.Normal)
            btUndo.backgroundColor = UIColor.redColor()
            btUndo.titleLabel?.font = font
            btUndo.addTarget(self, action: "btUndo_Clicked", forControlEvents: UIControlEvents.TouchUpInside)
            cell.swipeBackgroundView.addSubview(btUndo)
        }
        
        return cell
        
    }
    

    
    @IBAction func btDefer_Clicked(sender: UIButton)
    {
        
        if(self.paymentTrackerRecord.count > 0){
            for payment in self.paymentTrackerRecord
            {
                if(payment.Defer == "Deferred")
                {
                    
                    view.showLoading()
                    
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
                                LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                                
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
        
            SetPayment.SetPayment(4)
            
            self.performSegueWithIdentifier("GoToMakeCreditPayment", sender: nil)
            
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
