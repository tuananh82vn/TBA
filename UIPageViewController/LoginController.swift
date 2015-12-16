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
                    LocalStore.setDRCode(temp1.DRCode)
                    
                    self.reset()
                    self.performSegueWithIdentifier("GoToDebtorSelect", sender: nil)
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

