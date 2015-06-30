//
//  MessagesTableViewController.swift
//  Chat App
//
//  Created by Clarence Ji on 11/24/14.
//  Copyright (c) 2014 Clarence Ji. All rights reserved.
//

import UIKit

class MessagesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var convID = 0
    var messageList = Array<String>()
    var convesationName = String()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sendMessage(sender: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        Server.sendNewMessage("\(convID)", username: userDefaults.objectForKey("current_user") as! String!, message: textField.text) { (success, content) -> () in
            self.messageList.append(self.textField.text)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Server.getMessagesForConversation("\(convID)", completitionClosure: { (success, content) -> () in
            if success {
                self.messageList = content!
                self.tableView.reloadData()
            } else {
                println("No message has been sent")
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = convesationName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return messageList.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
//        cell.textLabel?.text = messageList[indexPath.row]
        
        //if (message.sender == false){cell.textLabel?.textAlignment = .Right}
        if (indexPath.row % 2 == 0){
            cell.textLabel?.textAlignment = .Right
        }
        
        cell.textLabel?.text = messageList[indexPath.row]
        
        return cell
    }
}
