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
    
    var OldList = [InboxItem]()
    
    var NewList = [InboxItem]()
    
    var selectedInbox = InboxItem()
    
    
    var FinalList = [InboxItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        GetInboxItemFromLocal()
        
        GetInboxItemFromRCS()

        //self.tableView.reloadData()
    }
    
    func SaveNewInboxIntoLocalDatabase(){
        
        
        self.FinalList = self.OldList
        
        if(self.NewList.count > 0 ){
        
            for tempObject in self.NewList {
                
                let findObject = OldList.filter{ $0.MessageNo == tempObject.MessageNo }.first
                
                //If not found in old list - insert into database and oldlist
                if(findObject == nil)
                {
                    let isInserted = ModelManager.getInstance().insertInboxItem(tempObject)
                    
                    self.FinalList.append(tempObject)

                }
            }
        }
    }
    
    func GetInboxItemFromLocal(){
        
        //ModelManager.getInstance().deleteAllInboxItem()
        
        self.OldList = ModelManager.getInstance().getAllInboxItem()

    }
    
    func GetInboxItemFromRCS(){
        
        
        self.view.showLoading()
        
        WebApiService.GetInboxItems(LocalStore.accessRefNumber()!) { objectReturn in
            
            if let temp1 = objectReturn
            {
                
                self.view.hideLoading()

                if(temp1.IsSuccess)
                {
                    self.NewList = temp1.InboxList
                    
                    self.SaveNewInboxIntoLocalDatabase()

                    //Display the lasest message first
                    self.FinalList.sortInPlace({ $0.MessageNo > $1.MessageNo })

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
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.FinalList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! InboxItemViewCell
        
       
        cell1.lb_Date.text = self.FinalList[indexPath.row].Date
        
        
        let Type = self.FinalList[indexPath.row].Type
        
        
        var TypeDescription = ""
        
        if(Type == "T"){
            TypeDescription = "Message"
        }
        else
            if(Type == "D"){
                TypeDescription = "Letter"
        }
        
        cell1.lb_Type.text = TypeDescription
        
        if(self.FinalList[indexPath.row].Status == "Unread"){
            cell1.img_Status.image = UIImage(named: "circle_red")
        }
        else
        {
            cell1.img_Status.image = UIImage(named: "circle_blue")
        }
        

        return cell1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedInbox = self.FinalList[indexPath.row]
        
        self.performSegueWithIdentifier("GoToDetail", sender: nil)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToDetail" {
            
            let controller = segue.destinationViewController as! InboxItemViewController
            controller.inboxDetail = self.selectedInbox
            
        }
    }


}
