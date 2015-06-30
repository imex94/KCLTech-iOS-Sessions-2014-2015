//
//  ConversationListTableViewController.swift
//  Chat App
//
//  Created by Clarence Ji on 11/24/14.
//  Copyright (c) 2014 Clarence Ji. All rights reserved.
//

import UIKit

class ConversationListTableViewController: UITableViewController {
    var convolist = Array<String>()
    var convId = 0
    
    @IBAction func addNewConversation(sender: AnyObject) {
        var alert = UIAlertController(title: "New Conversation", message: "Enter the name of the conversation", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (alertTextField) -> Void in
            
        }
        alert.addAction(UIAlertAction(title: "save", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            let username = NSUserDefaults.standardUserDefaults().objectForKey("current_user") as? String
            
            Server.createNewConversation(textField.text, username: username!, completitionClosure: { (success, content) -> () in
                if(success){
                    println("Conversation created")
                    self.convolist.append(textField.text)
                    self.tableView.reloadData()
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Server.getConversations { (success, content) -> () in
            if success {
                self.convolist = content!
                self.tableView.reloadData()
            } else {
                println("No conversation yet!")
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return convolist.count
        
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        let temp = convolist[indexPath.row]
        if temp != "" {
        // Configure the cell...
            cell.textLabel?.text = convolist[indexPath.row]
            
        }
        
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        convId = indexPath.row + 1
        
        // the problem during the session was that we connected the action to a cell, this is why it animated twice
        performSegueWithIdentifier("showMessages", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var nextView = segue.destinationViewController as! MessagesTableViewController
        nextView.convID = convId
        nextView.convesationName = convolist[convId - 1]
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
