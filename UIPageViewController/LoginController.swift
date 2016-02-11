import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var refreshButton: UIButton!

    
    var timer: Timer!
    
    @IBOutlet weak var lbl_Label: UILabel!
    
    var textDisplay : [String] = ["Thank you for waiting...", "We are logging you into system...", "It will take few seconds..."]
    
    var timer2 = NSTimer()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshButton.rotate360Degrees(completionDelegate: self)
        
        loadData()

    }
    
    func loadData(){
        
        
        
        self.timer = Timer(duration: 10.0, completionHandler: {
            
            self.reset()
            
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                
                self.loadData()
            }
            
            alert.addAction(okAction)
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        
        })
        
        //Display text every 1 second
        self.timer2 = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "displayAtIndex", userInfo: nil, repeats: true)
        
        self.timer.start()
        
        WebApiService.GetDebtorInfo(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    LocalStore.setTotalOutstanding(temp1.TotalOutstanding.description)
                    LocalStore.setNextPaymentInstallment(temp1.NextPaymentInstallment.description)
                    LocalStore.setDRCode(temp1.DRCode)
                    LocalStore.setIsExistingArrangementManual(temp1.IsExistingArrangement)
                    LocalStore.setIsExistingArrangementCC(temp1.IsExistingArrangementCC)
                    LocalStore.setIsExistingArrangementDD(temp1.IsExistingArrangementDD)
                    LocalStore.setIsCoBorrowers(temp1.IsCoBorrowers)
                    LocalStore.setIsAllowMonthlyInstallment(temp1.IsAllowMonthlyInstallment)
                    if(temp1.MaxNoPay > 3 ){
                        temp1.MaxNoPay = 3
                    }
                    LocalStore.setMaxNoPay(temp1.MaxNoPay)
                    LocalStore.setThreePartDateDurationDays(temp1.client.ThreePartDateDurationDays)

                    self.reset()
                    if(temp1.IsCoBorrowers){
                        self.performSegueWithIdentifier("GoToDebtorSelect", sender: nil)
                    }
                    else
                    {
                        self.performSegueWithIdentifier("GoToBlank", sender: nil)
                    }
                    
                }
                else
                {
                    
                }
            }
            else
            {
                self.reset()
                
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    
                    self.loadData()
                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)

            }
        }
        
        
    }
    
    func displayAtIndex()
    {
        self.lbl_Label.text = textDisplay[self.index]
        self.index++
        if (index == self.textDisplay.count)
        {
            self.index = 0
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
            self.refreshButton.rotate360Degrees(completionDelegate: self)
    }
    
    func reset() {
        self.timer.stop()
        self.timer2.invalidate()
    }
}

