import UIKit

class HomeViewController: UIViewController, TKSideDrawerDelegate {
    
    @IBOutlet weak var deferButton: UIButton!
    @IBOutlet weak var callbackButton: UIButton!
    @IBOutlet weak var inboxButton: UIButton!
    @IBOutlet weak var instalmentButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var trackerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
//        var nav = self.navigationController?.navigationBar
//        
//        nav?.barStyle = UIBarStyle.Black
//        
//        nav?.tintColor = UIColor.yellowColor()
//
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        
//        imageView.contentMode = .ScaleAspectFit
//        // 4
//        let image = UIImage(named: "lock")
//        
//        imageView.image = image
//        // 5
//        navigationItem.titleView = imageView
        
//        let navItem = UINavigationItem(title: "Home")
//        
//        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
//        navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
//        
//        let showSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
//        let logoutButton = UIBarButtonItem(image: UIImage(named: "lock"), style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
//        
//        navItem.rightBarButtonItem = logoutButton
//        navItem.leftBarButtonItem = showSideDrawerButton
//        nav!.items = [navItem]
        
        //self.view.addSubview(navBar)
        
        // tao menu
        
        let sectionPrimary = self.sideDrawer.addSectionWithTitle("Main")
        sectionPrimary.addItemWithTitle("Make a payment", image: UIImage(named: "dollar")!)
        sectionPrimary.addItemWithTitle("Payment Tracker", image: UIImage(named: "payment")!)
        sectionPrimary.addItemWithTitle("Instalment Info",image: UIImage(named: "info")!)
        sectionPrimary.addItemWithTitle("Defer Payment",image: UIImage(named: "defer")!)
        sectionPrimary.addItemWithTitle("Schedule Callback",image: UIImage(named: "callback")!)
        sectionPrimary.addItemWithTitle("Inbox",image: UIImage(named: "Inbox")!)
        
        let sectionLabels = self.sideDrawer.addSectionWithTitle("Setting")
        sectionLabels.addItemWithTitle("Update credit card detail")
        sectionLabels.addItemWithTitle("Update bank account")
        sectionLabels.addItemWithTitle("Update personal information")
        sectionLabels.addItemWithTitle("Feedback")
        
        
        self.sideDrawer.style.headerHeight = 64
        self.sideDrawer.fill = TKSolidFill(color: UIColor(rgba: "#00757D"))
        //self.sideDrawer.fill = TKSolidFill(color: UIColor(red: 28 / 255.0, green: 171/255.0, blue: 241/255.0, alpha:0.5))
        self.sideDrawer.style.shadowMode = TKSideDrawerShadowMode.Hostview
        self.sideDrawer.style.shadowOffset = CGSizeMake(-2, -0.5)
        self.sideDrawer.style.shadowRadius = 5
        self.sideDrawer.style.blurType = TKSideDrawerBlurType.None
        
        self.sideDrawer.transition = TKSideDrawerTransitionType.Push

        
        self.sideDrawer.delegate = self
        
        //----------------------------------------------------//

        let modelName = UIDevice.currentDevice().modelName

        setupButton(modelName);
        
    }
    
    func setupButton(iphone : String){
        if(iphone == "iPhone 6s Plus" || iphone == "iPhone 6 Plus" ){
            
        self.paymentButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0 , 0, 0)
        self.paymentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)

        self.trackerButton.titleEdgeInsets = UIEdgeInsetsMake(40, 5 , 0, 0)
        self.trackerButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)
        
        self.instalmentButton.titleEdgeInsets = UIEdgeInsetsMake(40, 10 , 0, 0)
        self.instalmentButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)
        
        self.deferButton.titleEdgeInsets = UIEdgeInsetsMake(40, 5 , 0, 0)
        self.deferButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)
        
        self.callbackButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0 , 0, 0)
        self.callbackButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)
        
        self.inboxButton.titleEdgeInsets = UIEdgeInsetsMake(40, 30 , 0, 0)
        self.inboxButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 55, 0, 0)
            
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
        NSLog("Selected item in section: %ld at index: %ld ", indexPath.section, indexPath.row)
        if(indexPath.section == 0 )
        {
            if(indexPath.row == 0 ){
                
                let makepaymentController = self.storyboard!.instantiateViewControllerWithIdentifier("MakePaymentViewController") as! MakePaymentViewController

                self.navigationController!.pushViewController(makepaymentController, animated: true)
                
            }
            
            if(indexPath.row == 1 ){
                
             //   let paymentTracker = self.storyboard!.instantiateViewControllerWithIdentifier("PaymentTrackerViewController") as! PaymentTrackerViewController
                
                let paymentTracker = self.storyboard!.instantiateViewControllerWithIdentifier("PaymentTracker2ViewController") as! PaymentTracker2ViewController

                
                self.navigationController!.pushViewController(paymentTracker, animated: true)
                
            }
            
            if(indexPath.row == 2 ){
                
                let instalmentInfoController = self.storyboard!.instantiateViewControllerWithIdentifier("InstalmentInfoViewController") as! InstalmentInfoViewController
                
                self.navigationController!.pushViewController(instalmentInfoController, animated: true)
            }
            
            if(indexPath.row == 4 ){
                
                let requestCallBackController = self.storyboard!.instantiateViewControllerWithIdentifier("RequestCallbackViewController") as! RequestCallbackViewController
                
                self.navigationController!.pushViewController(requestCallBackController, animated: true)
            }
        }
    }
    
    @IBAction func btInbox_Clicked(sender: AnyObject) {
    }
    
    @IBAction func btCallback_Clicked(sender: AnyObject) {
    }

    @IBAction func btDefer_Clicked(sender: AnyObject) {
    }
    
    @IBAction func btInstalment_Clicked(sender: AnyObject) {
    }
    
    @IBAction func btTracker_Clicked(sender: AnyObject) {
    }
    
    @IBAction func btPayment_Clicked(sender: AnyObject) {
        let makepaymentController = self.storyboard!.instantiateViewControllerWithIdentifier("MakePaymentViewController") as! MakePaymentViewController
        
        self.navigationController!.pushViewController(makepaymentController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

