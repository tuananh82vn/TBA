//
//  InstalmentInfoViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 9/11/2015.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit

class InstalmentInfoViewController: UIViewController , TKChartDelegate {

    
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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadData()
        
    }
    
    func loadData(){
        
        WebApiService.GetArrangmentDetail(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    self.lbl_ArrangeAmount.text = "$"+temp1.ArrangeAmount.description
                    self.lbl_Frequency.text = temp1.Frequency
                    self.lbl_NextPayDate.text = temp1.NextInstalmentDate
                    self.lbl_Overdue.text = "$"+temp1.OverdueAmount.description
                    self.lbl_Paid.text = "$"+temp1.PaidAmount.description
                    self.lbl_Remaining.text = "$"+temp1.LeftToPay.description
                    self.lbl_Status.text = temp1.Status
                    
                    LocalStore.setTotalPaid(temp1.PaidAmount.description)
                    LocalStore.setTotalOverDue(temp1.OverdueAmount.description)
                    
                    self.displayChart()
                }
                else
                {
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: temp1.Error, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                        UIAlertAction in
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }
                    
                    alert.addAction(okAction)
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)

                }
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    
                    self.navigationController?.popViewControllerAnimated(true)

                }
                
                alert.addAction(okAction)
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }

    }
    
    func displayChart(){
        
        
        self.IsDisplayChart = true
        
        let bounds = self.view_Chart.bounds
        
        pieChart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height), 10, 10)
        pieChart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        pieChart.delegate = self
        
        pieChart.allowAnimations = true
        pieChart.legend.hidden = false
        pieChart.legend.style.position = TKChartLegendPosition.Right
        self.view_Chart.addSubview(pieChart)
        
        var array:[TKChartDataPoint] = [TKChartDataPoint]()
        
        
        if let temp1 = LocalStore.accesssetTotalPaid()
        {
            let point1 = TKChartDataPoint(name: "Paid", value: temp1.floatValue)
            array.append(point1);
        }
        

        let point2 =  TKChartDataPoint(name: "Remaining", value: LocalStore.accessTotalOutstanding())
        array.append(point2);
 
        
        
        if let temp3 = LocalStore.accesssetTotalOverDue()
        {
            let point3 =  TKChartDataPoint(name: "Overdue", value: temp3.floatValue)
            array.append(point3);
        }
        
        let series = TKChartPieSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        series.displayPercentage = false;
        
        series.style.pointLabelStyle.textHidden = false;
        
        if(LocalStore.accessDeviceName() == "iPhone 6s Plus" || LocalStore.accessDeviceName() == "iPhone 6 Plus" ){

            series.style.pointLabelStyle.labelOffset = UIOffsetMake(10, 0)
        }
        else if(LocalStore.accessDeviceName() == "iPhone 5" || LocalStore.accessDeviceName() == "iPhone 5s" ){
                
                series.style.pointLabelStyle.labelOffset = UIOffsetMake(5, 0)
        }
        
        
        series.labelDisplayMode = TKChartPieSeriesLabelDisplayMode.Outside
        
        let  numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        series.style.pointLabelStyle.formatter = numberFormatter
        
        pieChart.addSeries(series)

    }
    
    override func viewDidAppear(animated: Bool)
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
    
    func chart(chart: TKChart, paletteItemForSeries series: TKChartSeries, atIndex index: Int) -> TKChartPaletteItem? {
        
        if index == 0 {
            let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor(rgba: "#75c283")))
            return green
        }
        else if index == 1 {
            let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor(rgba: "#00757D")))
            return blue
        }
        else if index == 2 {
            let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor(rgba: "#f14844")))
            return red
        }
        
        return nil
    }
    
    func chart(chart: TKChart, didSelectPoint point: TKChartData, inSeries series: TKChartSeries, atIndex index: Int) {
        print("didSelectPoint series at index: \(index)")
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
