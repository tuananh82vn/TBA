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
    
    @IBOutlet weak var View_NoInbox: UIView!
    
    @IBOutlet weak var View_Title: UIView!
    var FinalList = [InboxItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GetInboxItemFromLocal()
        
        GetInboxItemFromRCS()
        
        WebApiService.sendActivityTracking("Open Inbox")


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
                    self.FinalList.sort(by: { $0.MessageNo > $1.MessageNo })
                    
                    if(self.FinalList.count == 0){
                        self.View_NoInbox.isHidden = false
                        self.tableView.isHidden = true
                        self.View_Title.isHidden = true

                    }
                    else
                    {
                        self.View_NoInbox.isHidden = true
                        self.tableView.isHidden = false
                        self.View_Title.isHidden = false

                        self.tableView.reloadData()
                    }
                    
                }
                else
                {
                    if(temp1.Errors.count > 0){
                        LocalStore.Alert(self.view, title: "Error", message: temp1.Errors[0].ErrorMessage, indexPath: 0)
                    }
                    else
                    {
                        LocalStore.Alert(self.view, title: "Error", message: "Unexpected error.", indexPath: 0)
                    }
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.FinalList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! InboxItemViewCell
        
       
        cell1.lb_Date.text = self.FinalList[indexPath.row].Date
        
        
        let Type = self.FinalList[indexPath.row].ItemType
        
        
        var TypeDescription = ""
        
        if(Type == "T"){
            TypeDescription = "Message"
        }
        else
            if(Type == "D"){
                TypeDescription = "Letter"
        }
        else if(Type == "R"){
            TypeDescription = "Receipt"
        }
        else if(Type == "P"){
                TypeDescription = "Payment"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedInbox = self.FinalList[indexPath.row]
        
        self.performSegue(withIdentifier: "GoToDetail", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            
            let controller = segue.destination as! InboxItemViewController
            controller.inboxDetail = self.selectedInbox
            
        }
    }


}
