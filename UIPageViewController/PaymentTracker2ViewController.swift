//
//  PaymentTracker2ViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class PaymentTracker2ViewController: UIViewController, TKListViewDelegate , TKListViewDataSource, TKListViewStaggeredLayoutDelegate{

    
    @IBOutlet weak var subMainView: UIView!
    
    let listView = TKListView()
    
    var buttonAnimationEnabled = true
    
    var paymentTrackerRecord = [PaymentTrackerRecordModel]()
    
    var scrollDirection = TKListViewScrollDirection.Vertical
    
    var sizes = [Int]()

    var selectedRow : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData2()
        
        initData()
       
        listView.reloadData()

        // Do any additional setup after loading the view.
    }

    func initData(){
    
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.delegate = self
        listView.dataSource = self
        
        listView.allowsCellSwipe = true
        listView.cellSwipeLimits = UIEdgeInsetsMake(0, 60, 0, 0)//how far the cell may swipe
        listView.cellSwipeTreshold = 30 // the treshold after which the cell will autoswipe to the end and will not jump back to the center.
        listView.registerClass(CustomTelrikViewCell.classForCoder(), forCellWithReuseIdentifier: "custom")

        for _ in 0..<paymentTrackerRecord.count {
            sizes.append(Int(50 + 5*(arc4random()%40)))
        }
        

        self.subMainView.addSubview(listView)
        
        self.staggeredLayoutSelected()

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTouched() {
        
        print("Deder click at : %d", self.selectedRow)

        listView.endSwipe(true)
    }
    

    
    
    func enableButtonAnimation() {
        self.buttonAnimationEnabled = true
        listView.reloadData()
    }
    func disableButtonAnimation() {
        self.buttonAnimationEnabled = false
        listView.reloadData()
    }
    
    func initData2(){
        
        let record1 = PaymentTrackerRecordModel()
        record1.Amount = "$ 100.00"
        record1.DueDate = "12/20/2015"
        record1.Remaining = "$ 1000.00"
        record1.PaymentStatusId = 2
        paymentTrackerRecord.append(record1)
        
        let record2 = PaymentTrackerRecordModel()
        record2.Amount = "$ 100.00"
        record2.DueDate = "12/20/2015"
        record2.Remaining = "$ 1000.00"
        record2.PaymentStatusId = 0
        paymentTrackerRecord.append(record2)
        
        let record3 = PaymentTrackerRecordModel()
        record3.Amount = "$ 100.00"
        record3.DueDate = "12/20/2015"
        record3.Remaining = "$ 1000.00"
        record3.PaymentStatusId = 1
        paymentTrackerRecord.append(record3)
        
        let record4 = PaymentTrackerRecordModel()
        record4.Amount = "$ 100.00"
        record4.DueDate = "12/20/2015"
        record4.Remaining = "$ 1000.00"
        record4.PaymentStatusId = 0
        paymentTrackerRecord.append(record4)
        
        
        let record5 = PaymentTrackerRecordModel()
        record5.Amount = "$ 100.00"
        record5.DueDate = "12/20/2015"
        record5.Remaining = "$ 1000.00"
        record5.PaymentStatusId = 1
        paymentTrackerRecord.append(record5)
        
    }
    
    func staggeredLayoutSelected() {
        let layout = TKListViewStaggeredLayout()
        layout.delegate = self
        layout.itemSize = CGSizeMake(360, 40)
        layout.spanCount = 1
//        layout.itemSpacing = 1
//        layout.lineSpacing = 1
        layout.scrollDirection = self.scrollDirection
        layout.alignLastLine = true
        listView.layout = layout
    }
    
    func linearLayoutSelected() {
        let layout = TKListViewLinearLayout()
        layout.itemSize = CGSizeMake(360, 40)
        layout.itemSpacing = 1
        layout.scrollDirection = self.scrollDirection
        listView.layout = layout
    }
    
    // MARK: - TKListViewDelegate
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return self.paymentTrackerRecord.count
    }
    

    func listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        
        let cell1 = listView.dequeueReusableCellWithReuseIdentifier("custom", forIndexPath: indexPath) as! CustomTelrikViewCell
        
        cell1.lb_Amount.text = self.paymentTrackerRecord[indexPath.row].Amount
        
        cell1.lb_DueDate.text = self.paymentTrackerRecord[indexPath.row].DueDate
        
        cell1.lb_Remaining.text = self.paymentTrackerRecord[indexPath.row].Remaining
        
        if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 0 ){
            cell1.img_Status.image = UIImage(named: "circle_blue")

        }
        else
            if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 1 ){
                cell1.img_Status.image = UIImage(named: "circle_red")
            }
            else
                if(self.paymentTrackerRecord[indexPath.row].PaymentStatusId == 2 ){
                    cell1.img_Status.image = UIImage(named: "circle_green")
        }
        
        if(cell1.swipeBackgroundView.subviews.count == 0){
            let size = cell1.frame.size
            let font = UIFont.systemFontOfSize(14)
            let bFlag = UIButton()
            bFlag.frame = CGRectMake(0, 0, 60, size.height)
            bFlag.setTitle("Defer", forState: UIControlState.Normal)
            bFlag.backgroundColor = UIColor.orangeColor()
            bFlag.titleLabel?.font = font
            bFlag.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
            cell1.swipeBackgroundView.addSubview(bFlag)
        }

     
        
        return cell1
        
    }
    
    func listView(listView: TKListView, didSwipeCell cell: TKListViewCell, atIndexPath indexPath: NSIndexPath, withOffset offset: CGPoint) {
    }
    
    func listView(listView: TKListView, didFinishSwipeCell cell: TKListViewCell, atIndexPath indexPath: NSIndexPath, withOffset offset: CGPoint) {
        print("Swiped cell at indexPath: %d", indexPath.row)
        self.selectedRow = indexPath.row
    }
    
    func staggeredLayout(layout: TKListViewStaggeredLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
//        if layout.scrollDirection == TKListViewScrollDirection.Vertical {
//            return CGSizeMake(0, 80);
//        }
        
        return CGSizeMake(0, 40);

    }
    
    
    func listView(listView: TKListView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did select item at row\(indexPath.row)")

    }
    




}
