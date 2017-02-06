import UIKit

class LoginController: UIViewController {
    
    var timer: Timer!
        
    @IBOutlet weak var lbl_Label: UILabel!
    
    var textDisplay : [String] = ["Thank you for waiting...", "We are logging you into the system...", "It will take a few seconds..."]
    
    var timer2 = Foundation.Timer()
    
    var index = 0
    
    var debtorList = [CoDebtor]()
    
    @IBOutlet weak var logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        WebApiService.sendActivityTracking("Login")


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.logo.startRotating(duration: 2, clockwise: true)

    }
    
    
    func loadData(){
        
        
        self.timer = Timer(duration: 10.0, completionHandler: {
            
            self.timer.stop()
            
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                self.loadData()
            }
            
            alert.addAction(okAction)
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        })
        
        self.timer.start()
        
        //Display text every 2 second
        self.timer2 = Foundation.Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(LoginController.displayAtIndex), userInfo: nil, repeats: true)

        
        WebApiService.GetDebtorInfo(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    LocalStore.setTotalOutstanding(temp1.TotalOutstanding)
                    LocalStore.setNextPaymentInstallment(temp1.NextPaymentInstallment)
                    LocalStore.setIsExistingArrangement(temp1.IsExistingArrangement)
                    LocalStore.setIsExistingArrangementCC(temp1.IsExistingArrangementCC)
                    LocalStore.setIsExistingArrangementDD(temp1.IsExistingArrangementDD)
                    LocalStore.setIsCoBorrowers(temp1.IsCoBorrowers)
                    LocalStore.setIsAllowMonthlyInstallment(temp1.IsAllowMonthlyInstallment)
                    LocalStore.setWeeklyAmount(temp1.MinimumWeeklyOutstanding)
                    LocalStore.setMonthlyAmount(temp1.MinimumMonthlyOustanding)
                    LocalStore.setFortnightAmount(temp1.MinimumFortnightlyOutstanding)
                    LocalStore.setDRCode(temp1.DRCode)
                    LocalStore.setClientName(temp1.ClientName)
                    LocalStore.setClientAcc(temp1.ClientAcc)

                    if(temp1.MaxNoPay > 3 ){
                        temp1.MaxNoPay = 3
                    }
                    LocalStore.setMaxNoPay(temp1.MaxNoPay)
                    LocalStore.setThreePartDateDurationDays(temp1.client.ThreePartDateDurationDays)

                    self.logo.stopRotating()
                    
                    self.timer.stop()
                    
                    self.timer2.invalidate()
                    
                    self.performSegue(withIdentifier: "GoToBlank", sender: nil)

                    
                }
            }
            else
            {
                self.timer2.invalidate()
                
                self.timer.stop()
                
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.alert)
                
                
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    self.loadData()
                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.present(alert, animated: true, completion: nil)

            }
        }
        
        
    }
    
    func displayAtIndex()
    {
        self.lbl_Label.text = textDisplay[self.index]
        self.index += 1
        if (index == self.textDisplay.count)
        {
            self.index = 0
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDebtorSelect" {
            
            let controller = segue.destination as! SelectDebtorController
            controller.debtorList = self.debtorList
        }
    }
}

