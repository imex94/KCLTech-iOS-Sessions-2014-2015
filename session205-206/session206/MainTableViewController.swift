//
//  MainTableViewController.swift
//  session206
//
//  Created by Alex Telek on 07/12/2014.
//  Copyright (c) 2014 Alex Telek. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, MainTableCellDelegate {
    
    var darkView = UIView()
    var moveImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 306.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var  cell = tableView.dequeueReusableCellWithIdentifier("customCell") as? MainTableViewCell
        if (cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("MainTableViewCell", owner: self, options: nil).first as? MainTableViewCell
        }

        // Configure the cell...
        cell?.delegate = self
        
        return cell!
    }
    

    // MainTableViewCellDelegate - OPTIONAL
    func didClickOnImage(imageView: UIImageView) {
        //dark view
        darkView = UIView(frame: view.frame)
        darkView.backgroundColor = UIColor.blackColor()
        darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissImage:")))
        view.addSubview(darkView)
        
        // image view
        moveImageView = UIImageView(image: imageView.image)
        moveImageView.frame = imageView.frame
        moveImageView.contentMode = .ScaleAspectFit
        view.addSubview(moveImageView)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: { () -> Void in
            self.moveImageView.frame.size.height = 300
            self.moveImageView.frame.size.width = self.tableView.frame.width
            self.moveImageView.center = self.tableView.center
        }) { (finished) -> Void in
            
        }
    }
    
    func dismissImage(gesture: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.darkView.alpha = 0.0
            self.moveImageView.alpha = 0.0
        }) { (finished) -> Void in
            if finished {
                self.darkView.removeFromSuperview()
                self.moveImageView.removeFromSuperview()
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
