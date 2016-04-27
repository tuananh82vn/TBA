//
//  InboxViewController.swift
//  UIPageViewController
//
//  Created by andy synotive on 27/04/2016.
//  Copyright © 2016 Vea Software. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var InboxList = [InboxItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()

        // Do any additional setup after loading the view.
    }
    
    func initData(){
        
        WebApiService.GetInboxItems(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                if(temp1.IsSuccess)
                {
                    self.InboxList = temp1.InboxList
                    
                    
                    self.tableView.reloadData()
                    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.InboxList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! InboxItemViewCell
        
        

        
        var  tempDate = self.InboxList[indexPath.row].Date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(tempDate)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"

        cell1.lb_Date.text = dateFormatter.stringFromDate(date!)
        
        
        let Type = self.InboxList[indexPath.row].Type
        
        cell1.lb_Type.text = Type
            
        //cell1.img_Status.image = UIImage(named: "circle_red")
        
        
        return cell1
        
    }


}
