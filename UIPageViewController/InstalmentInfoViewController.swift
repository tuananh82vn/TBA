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
    
    var exampleBounds = CGRect.zero


    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleBounds = self.pieChartView.bounds;
        
        pieChart.delegate = self
        
        pieChart.frame = CGRectInset(CGRectMake(self.exampleBounds.origin.x, self.exampleBounds.origin.y, self.exampleBounds.size.width, self.exampleBounds.size.height ), 10, 10)
        
        pieChart.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        
        pieChart.allowAnimations = true
        
        pieChart.legend.hidden = false
        
        pieChart.legend.style.position = TKChartLegendPosition.Right
        
        self.pieChartView.addSubview(pieChart)
        
        let array:[TKChartDataPoint] = [
            TKChartDataPoint(name: "Paid", value: 20),
            TKChartDataPoint(name: "Remaining", value: 70),
            TKChartDataPoint(name:"Overdue", value: 10) ]
        
        let series = TKChartPieSeries(items:array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        series.selectionAngle = -M_PI_2
        series.expandRadius = 1.2
        
        let redFill = TKSolidFill(color: UIColor.redColor())
        
        pieChart.addSeries(series)

        series.style.pointLabelStyle.textHidden = false

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        pieChart.select(TKChartSelectionInfo(series:pieChart.series[0], dataPointIndex: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chart(chart: TKChart, paletteItemForSeries series: TKChartSeries, atIndex index: Int) -> TKChartPaletteItem? {
        
        if index == 0 {
            let green: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.greenColor()))
            return green
        }
        else if index == 1 {
            let blue: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.blueColor()))
            return blue
        }
        else if index == 2 {
            let red: TKChartPaletteItem = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.redColor()))
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
