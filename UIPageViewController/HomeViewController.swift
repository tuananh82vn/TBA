import UIKit

class HomeViewController: UIViewController, TKSideDrawerDelegate  {
    
    @IBOutlet weak var deferButton: UIButton!
    @IBOutlet weak var callbackButton: UIButton!
    @IBOutlet weak var inboxButton: UIButton!
    @IBOutlet weak var instalmentButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var trackerButton: UIButton!
    @IBOutlet weak var lbl_refnumber: UILabel!
    @IBOutlet weak var lbl_outstanding: UILabel!
    @IBOutlet weak var lbl_nextinstalment: UILabel!
    
    @IBOutlet weak var lbl_labelNextInstalment: UILabel!
    @IBOutlet weak var view_Chart: UIView!
    
    
    let pieChart = TKChart()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        //Andy test
        //ModelManager.getInstance().deleteAllInboxItem()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        // create menu
        let sectionPrimary = self.sideDrawer.addSectionWithTitle("Main")
        
        sectionPrimary.addItemWithTitle("Pay In Full", image: UIImage(named: "dollar")!)
        
        if(LocalStore.accessIsExistingArrangement()! || LocalStore.accessIsExistingArrangementCC()! || LocalStore.accessIsExistingArrangementDD()!){

        }
        else
        {
            sectionPrimary.addItemWithTitle("Setup Schedule Payment", image: UIImage(named: "instalment")!)
        }

        sectionPrimary.addItemWithTitle("Provide Feedback",image: UIImage(named: "info")!)
        
        let sectionLabels = self.sideDrawer.addSectionWithTitle("Settings")
        
        sectionLabels.addItemWithTitle("View / Update Credit Card Detail", image: UIImage(named: "creditcard")!)

        sectionLabels.addItemWithTitle("View / Update Bank Account Detail", image: UIImage(named: "bank")!)
        
        sectionLabels.addItemWithTitle("View / Update Personal Information", image: UIImage(named: "personal")!)
        
        self.sideDrawer.style.headerHeight = 64
        self.sideDrawer.fill = TKSolidFill(color: UIColor(rgba: "#00757D"))
        self.sideDrawer.style.shadowMode = TKSideDrawerShadowMode.Hostview
        self.sideDrawer.style.shadowOffset = CGSizeMake(-2, -0.5)
        self.sideDrawer.style.shadowRadius = 5
        self.sideDrawer.style.blurType = TKSideDrawerBlurType.None
        
        self.sideDrawer.transition = TKSideDrawerTransitionType.Push

        
        self.sideDrawer.delegate = self
        
        //----------------------------------------------------//


        setupButton(LocalStore.accessDeviceName())
        
        self.lbl_refnumber.text = LocalStore.accessRefNumber()
        
        //Format number
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.currencySymbol = "$"

        self.lbl_outstanding.text = formatter.stringFromNumber(LocalStore.accessTotalOutstanding())
        
        if(LocalStore.accessNextPaymentInstallment() > 0 ){
            self.lbl_labelNextInstalment.hidden = false
            self.lbl_nextinstalment.text = formatter.stringFromNumber(LocalStore.accessNextPaymentInstallment())
        }
        else
        {
            self.lbl_labelNextInstalment.hidden = true
            self.lbl_nextinstalment.text = ""
        }
        
        
        
        SetPayment.SetPayment(0)
        
        LocalStore.setFrequency(0)

        self.SendAppsDetail()
        
    }
    
    func SendAppsDetail(){
        //Send App Detail to RCS
        WebApiService.sendAppDetail(LocalStore.accessRefNumber()!, PinNumber: LocalStore.accessPin()! , DeviceToken:  LocalStore.accessDeviceToken()) { objectReturn in
            
            if let temp1 = objectReturn
            {
                self.view.hideLoading();
                
                if(temp1.IsSuccess)
                {
                    print("Apps detail sent")
                    print("Token:" + LocalStore.accessDeviceToken())
                }
            }
        }
    }
    
//    override func viewDidAppear(animated: Bool)
//    {
//        super.viewDidAppear(animated)
//    }
    
    
    func setupButton(iphone : String){
        
        if(iphone == "iPhone 6s Plus" || iphone == "iPhone 6 Plus" ){
            
            self.paymentButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 55, 0, 0)
            self.trackerButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 55, 0, 0)
            self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)

        
            self.deferButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 55, 0, 0)
            self.callbackButton.imageEdgeInsets =   UIEdgeInsetsMake(-20, 55, 0, 0)
            self.inboxButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 55, 0, 0)
            

            self.paymentButton.titleEdgeInsets =    UIEdgeInsetsMake(40, 0 , 0, 0)
            self.trackerButton.titleEdgeInsets =    UIEdgeInsetsMake(40, 5 , 0, 0)
            self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, 10 , 0, 0)
            
            
            self.deferButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 5 , 0, 0)
            self.callbackButton.titleEdgeInsets =   UIEdgeInsetsMake(40, 0 , 0, 0)
            self.inboxButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 30 , 0, 0)
      
        }
        else if(iphone == "iPhone 6s" || iphone == "iPhone 6" ){
                
                self.paymentButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 50, 0, 0)
                self.trackerButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 50, 0, 0)
                self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 50, 0, 0)
                
                
                self.deferButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 50, 0, 0)
                self.callbackButton.imageEdgeInsets =   UIEdgeInsetsMake(-20, 50, 0, 0)
                self.inboxButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 50, 0, 0)
                
                self.paymentButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -5 , 0, 0)
                self.trackerButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -5 , 0, 0)
                self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0 , 0, 0)
                
                self.deferButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 0 , 0, 0)
                self.callbackButton.titleEdgeInsets =   UIEdgeInsetsMake(40, -10 , 0, 0)
                self.inboxButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 20 , 0, 0)

                
        }
        else if(iphone == "iPhone 5" || iphone == "iPhone 5s"  )
        {
            self.paymentButton.imageEdgeInsets =    UIEdgeInsetsMake(-17, 45, 0, 0)
            self.trackerButton.imageEdgeInsets =    UIEdgeInsetsMake(-17, 40, 0, 0)
            self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-17, 40, 0, 0)
            
            
            self.deferButton.imageEdgeInsets =      UIEdgeInsetsMake(-17, 45, 0, 0)
            self.callbackButton.imageEdgeInsets =   UIEdgeInsetsMake(-17, 40, 0, 0)
            self.inboxButton.imageEdgeInsets =      UIEdgeInsetsMake(-17, 40, 0, 0)
            
            self.paymentButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -10 , 0, 0)
            self.trackerButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -10 , 0, 0)
            self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, -10 , 0, 0)
            
            self.deferButton.titleEdgeInsets =      UIEdgeInsetsMake(40, -5 , 0, 0)
            self.callbackButton.titleEdgeInsets =   UIEdgeInsetsMake(40, -17 , 0, 0)
            self.inboxButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 13 , 0, 0)

        }
        
        else if(iphone == "iPhone 4s" )
        {
            self.paymentButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 40, 0, 0)
            self.trackerButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 40, 0, 0)
            self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 40, 0, 0)

            self.deferButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 40, 0, 0)
            self.callbackButton.imageEdgeInsets =   UIEdgeInsetsMake(-20, 40, 0, 0)
            self.inboxButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 40, 0, 0)
            
            self.paymentButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -12 , 0, 0)
            self.trackerButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -12 , 0, 0)
            self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, -10 , 0, 0)
            
            
            self.deferButton.titleEdgeInsets =      UIEdgeInsetsMake(40, -5 , 0, 0)
            self.callbackButton.titleEdgeInsets =   UIEdgeInsetsMake(40, -17 , 0, 0)
            self.inboxButton.titleEdgeInsets =      UIEdgeInsetsMake(40,  15 , 0, 0)

        }
        
        else if(iphone == "Simulator")
        {
            self.paymentButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 45, 0, 0)
            self.trackerButton.imageEdgeInsets =    UIEdgeInsetsMake(-20, 45, 0, 0)
            self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 40, 0, 0)
            
            
            self.deferButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 45, 0, 0)
            self.callbackButton.imageEdgeInsets =   UIEdgeInsetsMake(-20, 45, 0, 0)
            self.inboxButton.imageEdgeInsets =      UIEdgeInsetsMake(-20, 40, 0, 0)
            
            self.paymentButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -15 , 0, 0)
            self.trackerButton.titleEdgeInsets =    UIEdgeInsetsMake(40, -10 , 0, 0)
            self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, -10 , 0, 0)
            
            self.deferButton.titleEdgeInsets =      UIEdgeInsetsMake(40, -5 , 0, 0)
            self.callbackButton.titleEdgeInsets =   UIEdgeInsetsMake(40, -15, 0, 0)
            self.inboxButton.titleEdgeInsets =      UIEdgeInsetsMake(40, 15 , 0, 0)
            
        }

        
    }
    
    @IBAction func menuClicked(sender: AnyObject) {
        self.sideDrawer.show()

    }
    
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForItemAtIndexPath indexPath: NSIndexPath!) {
        let section = sideDrawer.sections[indexPath.section] as! TKSideDrawerSection
        let item = section.items[indexPath.item] as! TKSideDrawerItem
        item.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        item.style.separatorColor = TKSolidFill(color: UIColor(white: 1, alpha: 0.5))
        item.style.textColor = UIColor.whiteColor()
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForSection sectionIndex: Int) {
        let section = sideDrawer.sections[sectionIndex] as! TKSideDrawerSection
        section.style.textColor = UIColor.whiteColor()
        section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0)
    }
    
    
    func sideDrawer(sideDrawer: TKSideDrawer!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
//        NSLog("Selected item in section: %ld at index: %ld ", indexPath.section, indexPath.row)
        if(indexPath.section == 0 )
        {
           if(indexPath.row == 0 ){
            
                SetPayment.SetPayment(1)

                let paymentMethodController = self.storyboard!.instantiateViewControllerWithIdentifier("PaymentMethodViewController") as! PaymentMethodViewController
            
                self.navigationController!.pushViewController(paymentMethodController, animated: true)
            
            }
            
            if(indexPath.row == 1 ){
                
                if(LocalStore.accessIsExistingArrangement()! || LocalStore.accessIsExistingArrangementCC()! || LocalStore.accessIsExistingArrangementDD()!){
                    
                    let view = self.storyboard!.instantiateViewControllerWithIdentifier("SendFeedbackViewController") as! SendFeedbackViewController
                    
                    self.navigationController!.pushViewController(view, animated: true)
                    
                }
                else
                {
                    let view = self.storyboard!.instantiateViewControllerWithIdentifier("SetupPaymentViewController") as! SetupPaymentViewController
                    
                    self.navigationController!.pushViewController(view, animated: true)
                }
            }
            
            if(LocalStore.accessIsExistingArrangement()! || LocalStore.accessIsExistingArrangementCC()! || LocalStore.accessIsExistingArrangementDD()!){
                
                
            }
            else
            {
                if(indexPath.row == 2 ){
                    
                    let view = self.storyboard!.instantiateViewControllerWithIdentifier("SendFeedbackViewController") as! SendFeedbackViewController
                    
                    self.navigationController!.pushViewController(view, animated: true)
                }
            }
            

        }
        else if(indexPath.section == 1 )
        {

                if(indexPath.row == 0 ){
                        
                        
                        let view = self.storyboard!.instantiateViewControllerWithIdentifier("UpdateCreditCardViewController") as! UpdateCreditCardViewController
                        
                        self.navigationController!.pushViewController(view, animated: true)
                        
                }
                else
                if(indexPath.row == 1 ){
                
                
                        let view = self.storyboard!.instantiateViewControllerWithIdentifier("UpdateBankAccountViewController") as! UpdateBankAccountViewController
                
                        self.navigationController!.pushViewController(view, animated: true)
                
                }
                else
                if(indexPath.row == 2 ){
                        
                        
                        let view = self.storyboard!.instantiateViewControllerWithIdentifier("UpdatePersonalInfoViewController") as! UpdatePersonalInfoViewController
                        
                        self.navigationController!.pushViewController(view, animated: true)
                        
                }

        }
    }
    
    @IBAction func btInbox_Clicked(sender: AnyObject) {
//        JLToast.makeText("Coming up ...", duration: JLToastDelay.ShortDelay).show()
        
        let requestCallBackController = self.storyboard!.instantiateViewControllerWithIdentifier("InboxViewController") as! InboxViewController
        
        self.navigationController!.pushViewController(requestCallBackController, animated: true)
    }
    
    @IBAction func btCallback_Clicked(sender: AnyObject) {
        
        let requestCallBackController = self.storyboard!.instantiateViewControllerWithIdentifier("RequestCallbackViewController") as! RequestCallbackViewController
        
        self.navigationController!.pushViewController(requestCallBackController, animated: true)
        
    }

    @IBAction func btDefer_Clicked(sender: AnyObject) {
        
        let instalmentInfoViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DeferPaymentViewController") as! DeferPaymentViewController
        
        self.navigationController!.pushViewController(instalmentInfoViewController, animated: true)
    }
    
    @IBAction func btInstalment_Clicked(sender: AnyObject) {
        
        let instalmentInfoViewController = self.storyboard!.instantiateViewControllerWithIdentifier("InstalmentInfoViewController") as! InstalmentInfoViewController
        
        self.navigationController!.pushViewController(instalmentInfoViewController, animated: true)
    }
    
    @IBAction func btTracker_Clicked(sender: AnyObject) {
        
        if(LocalStore.accessIsArrangementUnderThisDebtor()){
            
            let paymentTrackerViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PaymentTrackerViewController") as! PaymentTrackerViewController
        
            self.navigationController!.pushViewController(paymentTrackerViewController, animated: true)
            
        }
        else
        {
            LocalStore.Alert(self.view, title: "Error", message: "You don't have permission to view this arrangement", indexPath: 0)
        }
    }
    
    @IBAction func btPayment_Clicked(sender: AnyObject) {
        
        SetPayment.SetPayment(4)
        
        let makeCreditPaymentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MakeCreditPaymentViewController") as! MakeCreditPaymentViewController
        
        self.navigationController!.pushViewController(makeCreditPaymentViewController, animated: true)
        
    }
    @IBAction func btLogout_Clicked(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let logoutAction = UIAlertAction(title: "Log off", style: UIAlertActionStyle.Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            

                self.Logout()
            
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        

        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        

        
    }
    
    func Logout(){
        
        let pinLoginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PinLoginViewController") as! PinLoginViewController
        
        self.navigationController!.pushViewController(pinLoginViewController, animated: false)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

