//
//  InstalmentInfoViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class InstalmentInfoViewController: UIViewController , TKChartDelegate {

    @IBOutlet weak var view_NoArrangement: UIView!
    
    @IBOutlet weak var pieChartView: UIView!
    
    let pieChart = TKChart()

    @IBOutlet weak var lbl_ArrangeAmount: UILabel!
    @IBOutlet weak var lbl_Frequency: UILabel!
    @IBOutlet weak var lbl_Paid: UILabel!
    @IBOutlet weak var lbl_Remaining: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Overdue: UILabel!
    @IBOutlet weak var lbl_NextPayDate: UILabel!
    
    
    @IBOutlet weak var view_Chart: UIView!
    
    var IsDisplayChart =  false
    
    var IsGreen = false
    var IsBlue = false
    var IsRed = false
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view_NoArrangement.isHidden = true
        self.view_NoArrangement.isUserInteractionEnabled = false
        
        loadData()
        
        WebApiService.sendActivityTracking("Open Instalment Info")

        
    }
    
    @IBAction func makePayment_Clicked(_ sender: AnyObject) {
        SetPayment.SetPayment(4)
        
        self.performSegue(withIdentifier: "GoToMakePayment", sender: nil)
    }
    func loadData(){
        
        WebApiService.GetArrangmentDetail(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    
                

                    self.view_NoArrangement.isHidden = true
                    self.view_NoArrangement.isUserInteractionEnabled = false
                    
                    self.lbl_ArrangeAmount.text =  Double(temp1.ArrangeAmount).formatAsCurrency()
                    
                    self.lbl_Frequency.text = temp1.Frequency
                    self.lbl_NextPayDate.text = temp1.NextInstalmentDate
                    self.lbl_Overdue.text = Double(temp1.OverdueAmount).formatAsCurrency()
                    
                    self.lbl_Paid.text = Double(temp1.PaidAmount).formatAsCurrency()
                    self.lbl_Remaining.text = Double(temp1.LeftToPay).formatAsCurrency()
                    self.lbl_Status.text = temp1.Status
                    
                    LocalStore.setTotalPaid(temp1.PaidAmount.description)
                    LocalStore.setTotalOverDue(temp1.OverdueAmount.description)
                    
                    self.displayChart()
                }
                else
                {
                    self.view_NoArrangement.isUserInteractionEnabled = true

                    self.view_NoArrangement.isHidden = false

                }
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    self.navigationController?.popViewController(animated: true)

                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
        }

    }
    
    func displayChart(){
        
        
        self.IsDisplayChart = true
        
        let bounds = self.view_Chart.bounds
        
        pieChart.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 20, height: bounds.size.height - 20).insetBy(dx: 10, dy: 10)
        
        
        if(LocalStore.accessDeviceName() == "iPhone 4s"){
            
            pieChart.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 20, height: bounds.size.height - 40).insetBy(dx: 10, dy: 10)

        }
        
        pieChart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing().rawValue)
        
        pieChart.delegate = self
        
        pieChart.allowAnimations = true
        pieChart.legend.isHidden = false
        pieChart.legend.style.position = TKChartLegendPosition.right
        self.view_Chart.addSubview(pieChart)
        
        var array:[TKChartDataPoint] = [TKChartDataPoint]()
        
        
        if let temp1 = LocalStore.accesssetTotalPaid()
        {
            if(temp1.floatValue > 0 )
            {
                let point1 = TKChartDataPoint(name: "Paid", value: temp1.floatValue)
                array.append(point1);
                self.IsGreen = true
            }
        }
        
        let temp2 = LocalStore.accessTotalOutstanding()
        
        if(temp2 > 0 )
        {
            let point2 = TKChartDataPoint(name: "Remaining", value: temp2)
            array.append(point2);
            self.IsBlue = true

        }
        
        if let temp3 = LocalStore.accesssetTotalOverDue()
        {
            if(temp3.floatValue > 0 )
            {
                let point3 = TKChartDataPoint(name: "Overdue", value: temp3.floatValue)
                array.append(point3);
                self.IsRed = true
            }
        }
        
        
        
        let series = TKChartPieSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.dataPoint
//        series.selectionAngle = -M_PI_2
        
        series.expandRadius = 1.3
        series.adjustSizeToFit = true

        series.displayPercentage = false;
        series.style.pointLabelStyle.textHidden = false;
        
        if(LocalStore.accessDeviceName() == "iPhone 6s Plus" || LocalStore.accessDeviceName() == "iPhone 6 Plus" || LocalStore.accessDeviceName() == "iPhone 7 Plus"){

            series.style.pointLabelStyle.labelOffset = UIOffsetMake(10, 0)
        }
        else if(LocalStore.accessDeviceName() == "iPhone 6s" || LocalStore.accessDeviceName() == "iPhone 6" || LocalStore.accessDeviceName() == "iPhone 7"){
            
            series.style.pointLabelStyle.labelOffset = UIOffsetMake(10, 0)
        }
        else if(LocalStore.accessDeviceName() == "iPhone 5" || LocalStore.accessDeviceName() == "iPhone 5s" ){
                
                series.style.pointLabelStyle.labelOffset = UIOffsetMake(7, 0)
        }
        else if(LocalStore.accessDeviceName() == "iPhone 4s"){
            
            series.style.pointLabelStyle.labelOffset = UIOffsetMake(5, 0)
        }
        else if(LocalStore.accessDeviceName() == "Simulator"){
            
            series.style.pointLabelStyle.labelOffset = UIOffsetMake(5, 0)
        }
        
        series.labelDisplayMode = TKChartPieSeriesLabelDisplayMode.outside
        
        let  numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        
        series.style.pointLabelStyle.formatter = numberFormatter
        
        pieChart.addSeries(series)

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if(self.IsDisplayChart){
            pieChart.select(TKChartSelectionInfo(series:pieChart.series[0], dataPointIndex: 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chart(_ chart: TKChart, paletteItemFor series: TKChartSeries, at index: Int) -> TKChartPaletteItem? {
        
        
        if(self.IsGreen && self.IsBlue && self.IsRed)
        {
            if index == 0 {
                let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex: "#75c283")))
                return green
            }
            else if index == 1 {
                let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#00757D")))
                return blue
            }
            else if index == 2 {
                let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#f14844")))
                return red
            }
        }
        else if(self.IsGreen && self.IsBlue)
        {
            if index == 0 {
                let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#75c283")))
                return green
            }
            else if index == 1 {
                let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex: "#00757D")))
                return blue
            }
        }
        else if(self.IsGreen && self.IsRed)
        {
            if index == 0 {
                let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#75c283")))
                return green
            }
            else if index == 1 {
                let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#f14844")))
                return red
            }
        }
        else if(self.IsBlue && self.IsRed)
        {
            if index == 0 {
                let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#00757D")))
                return blue
            }
            else if index == 1 {
                let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#f14844")))
                return red
            }
        }
        else if(self.IsGreen)
        {
            if index == 0 {
                let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#75c283")))
                return green
            }
        }
        else if(self.IsBlue)
        {
            if index == 0 {
                let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#00757D")))
                return blue
            }
        }
        else if(self.IsRed)
        {
            if index == 0 {
                let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.init(hex:  "#f14844")))
                return red
            }
        }
        return nil
    }
    
    func chart(_ chart: TKChart, didSelectPoint point: TKChartData, in series: TKChartSeries, at index: Int) {
        //print("didSelectPoint series at index: \(index)")
    }
    
//    func chart(chart: TKChart, didDeselectSeries series: TKChartSeries) {
//        print("didDeselectSeries series at index: \(series.index)")
//    }
//    
//    func chart(chart: TKChart, didDeselectPoint point: TKChartData, inSeries series: TKChartSeries, atIndex index: Int) {
//        print("didDeselectPoint series at index: \(series.index)")
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
